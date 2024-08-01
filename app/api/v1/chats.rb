module V1
  class Chats < Grape::API

    helpers do
      def chat_params
        declared(params, include_blank: false)
      end
    end
    
    resource :chats do
      get do
        present Chat.all, with: V1::Entities::Chats
      end

      desc "create chat"
      params do
        requires :chats, type: Hash do
          requires :participants, type: Array[Integer]
        end
      end
      post do
        get_chat = Chat.find_chat(chat_params[:chats][:participants])

        unless get_chat.present?
          chat = Chat.new(chat_params.dig("chats"))
          if chat.save
            chat
          else
            error!(chat.get_object_errors, 422)
          end
          
        else
          get_chat
        end
      end
    end

  end
end