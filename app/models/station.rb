class Station < ApplicationRecord
  
  has_many :schedules, class_name: "Schedule", foreign_key: "source_station_id",                      dependent: :nullify
  has_many :trains,    class_name: "Train",    foreign_key: "source_station_id", through: :schedules, dependent: :nullify
  
  validates :name, :city, :location, presence: true
end