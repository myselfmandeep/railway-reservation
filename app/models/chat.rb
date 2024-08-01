class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy

  # def participants
  #   User.where(id: attributes.dig("participants"))
  # end

  validate :valid_participants
  
  scope :find_chat, -> (users=[]) {
    where("participants @> ARRAY[?]", users)&.first
  }

  def valid_participants
    errors.add(:participants, "are invalid") unless User.where(id: participants).count == participants.count 
    errors.add(:base, "Invalid number of participants") unless participants.size == 2 
  end
  
end