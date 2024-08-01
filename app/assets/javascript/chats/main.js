
import createConsumer from "../channels/consumer"
import { chattingBox } from "./chatting";
import { handleErrors } from "./print_errors";
import { getUser } from "./user";

const getToken = function () {
  return localStorage.token;
};

const getChatBox = function () {
  return document.querySelector("#chat-box");
};

const closePreviousChat = function () {
  const subscriptions = createConsumer.subscriptions.subscriptions;

  if (subscriptions.length > 0) {
    const sub = subscriptions[0]
    getChatBox().remove();
    sub.unsubscribe();
    sub.disconnected();
  }
};

const closeChatAndUnsub  = function (subscription) {
  const chatBox = document.querySelector("#chat-box");
  chatBox.remove();

  subscription.unsubscribe();
  subscription.disconnected()
};

const requestHeaders = function() {
  return {
    "Content-Type": "application/json",
    "authorization" : `Bearer ${getToken()}`
  }
};

const executeOnConnect = function () {
  alert("chat initiated...")
};

const executeOnDisconnect = function () {
  alert("chat closed...")
};

const executeOnReceive = function (data) {
  console.log(data)
          
  const messageContainer = document.querySelector("#messages");
  messageContainer.insertAdjacentHTML("beforeend", `<p>${data.message}</p>`)
};

const appendChatBox = function() {
  const chatContainer = document.querySelector("#chat-container");
  chatContainer.insertAdjacentHTML("afterbegin", chattingBox());
};

const preventDefaultClick = function(element) {
  element.addEventListener("click", (e) => e.preventDefault());
};

const userNames = Array.from((document.querySelectorAll(".username") || []));

userNames.forEach(function(user) {
  user.addEventListener("click", function(event) {
    
    if (!(localStorage.token && localStorage.userId)) { return getUser(); }
    
    if (!!getChatBox()) { closePreviousChat() };

    // initiate chat
    const options = {
      method:"POST",
      headers: requestHeaders(),
      body: JSON.stringify({
        "chats" : {
          "participants" : [user.dataset.userId, localStorage.userId]
        }
      })
    };

    fetch("/api/v1/chats", options)
    .then((res=> {

      if (res.status == 401) {
        getUser();
      }

      return res.json();
    }))
    .then((data) => {
      console.log(data);
      const errors = data.error;
      if (errors) {
        handleErrors(errors)
        
        return;
      }
      
      appendChatBox();
    
      const sendMessageBtn = document.querySelector("#send-message-btn");
      preventDefaultClick(sendMessageBtn)
      
      const chat = Array.isArray(data) ? data[0] : data;

      if (!chat) { return console.log(chat) };
      
      const chatId = chat.id
      const identifier   = {"channel": "ChatChannel", chat_id: chatId}
      const channelEvents =  { connected: executeOnConnect, disconnected: executeOnDisconnect, received: executeOnReceive }
      const subscription = createConsumer.subscriptions.create(identifier, channelEvents)

      const messageTypingBox = document.querySelector("#message-typing-box");
      const chatCloseBtn     = document.querySelector("#chat-close-btn");

      chatCloseBtn.addEventListener("click", function(closeBtn) {
        closeChatAndUnsub(subscription);
      });

      // click on send button
      sendMessageBtn.addEventListener("click", function(sendMessage) {
        sendMessage.preventDefault();

        const url     = "/api/v1/messages";
        const options = {
          method:"POST",
          headers: requestHeaders(),
          body: JSON.stringify({
            "chat_id": chatId,
            "messages": {
              "body": messageTypingBox.value, sender_id: localStorage.userId
            }
          })
        };

        messageTypingBox.value = ""

        const message = fetch(url, options).then(res => res.json());

        message.then(((response) => {
          const errors = response.error

          if (errors) {
            return handleErrors(errors)
          }
          
        })) 
      })
    })
  })
});

