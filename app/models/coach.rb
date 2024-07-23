class Coach < ApplicationRecord

  # WAITING_COACH = Coach.find_by(name: nil).freeze
  
  # CLASS = {
  #   "1AC" => "1 Tier AC",
  #   "2AC" => "2 Tier AC",
  #   "3AC" => "3 Tier AC",
  #   "EV"  => "Vistadome AC",
  #   "EA"  => "Anubhuti Class",
  #   "EC"  => "Executive Chair",
  #   "FC"  => "First Class",
  #   "3E"  => "3 AC Economy",
  #   "CC"  => "AC Chair Car",
  #   "SL"  => "Sleeper",
  #   "2S"  => "Second Sitting"
  # }.freeze

  # PRICES = {
  #   "1AC" => 5,
  #   "2AC" => 4,
  #   "3AC" => 3,
  #   "EV"  => 2.5,
  #   "EA"  => 2.1,
  #   "EC"  => 1.7,
  #   "FC"  => 1.65,
  #   "3E"  => 1.2,
  #   "CC"  => 1.25,
  #   "SL"  => 0.90,
  #   "2S"  => 0.75
  # }.freeze
  
  # SLUG_NAMES  = CLASS.keys.freeze
  # CLASS_NAMES = CLASS.values.freeze
  
  has_many   :seats, dependent: :destroy
  belongs_to :tier
  
  validates :name,        presence: true, length: {minimum: 3, maximum: 15}
  validates :description,                 length: {minimum: 0, maximum: 40}
  # validates :category,   inclusion: {in: CLASS_NAMES}
  # validates :slug_name,  inclusion: {in: SLUG_NAMES}

end
