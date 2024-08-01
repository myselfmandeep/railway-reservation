module V1
  module Entities
    class Chats < Base
      # expose :participants, with: Users
      expose :messages, with: Messages
    end
  end
end