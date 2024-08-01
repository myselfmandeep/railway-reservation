function chattingBox() {
  return `
  <div class="col-8 d-flex flex-column border border-secondary" id="chat-box">
    <div class="col-5" id="messages" style="height: 70vh; width: 80vw">
    </div>
      <div class="col-3">
        <form action="/api/v1/messages" accept-charset="UTF-8" method="post">
          <div class="mb-3">
            <input placeholder="type a message" id="message-typing-box" type="text" name="message[body]">
          </div>
          <div class="mb-3">
            <input type="submit" name="commit" value="Send" id="send-message-btn" class="btn btn-primary data-disable-with=" send"="">
            <div class="btn btn-danger" id="chat-close-btn">close</div>
          </div>
        </form>
      </div>
  </div>`
}

export {chattingBox}