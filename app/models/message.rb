class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: "User"

  validate :chat_member

  def chat_member
    errors.add(:base, "You are not part of this chat") unless chat.participants.include?(sender.id)
  end
  
end