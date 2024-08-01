module V1
  class Messages < Grape::API

    helpers do
      def message_params
        declared(params, include_blank: false).dig("messages").merge!({chat_id: params[:chat_id]})
      end
    end

    resource :messages do

      params do
        requires :chat_id, type: String
      end
      
      before do
        @chat = Chat.find(params[:chat_id])
      end
      
      get do
        @chat.messages
      end
      
      desc "create message"
      params do
        requires :messages, type: Hash do
          requires :sender_id, type: Integer, desc: "sender of message"
          requires :body,      type: String,  desc: "text message"
        end
      end
      post do
        message = @chat.messages.build(message_params)

        if message.save
          # the message will broadcast with different app(hosting websocket connection)

          conn = Faraday.new(ENV['WEBHOOK_URL'], headers: {"Content-Type" => "application/json"});

          req = conn.post("/api/v1/broadcast_message") do |r|
            r.body = message.to_json
          end
        else
          error!(message.get_object_errors, 422)
        end

      end
      



      
      
    end
      

  end
end