class Schedule < ApplicationRecord
  # self.table_name = "train_routes"

  has_many :bookings
  
  belongs_to :train
  belongs_to :source_station,      class_name: "Station"
  belongs_to :destination_station, class_name: "Station"

  validates :arrived_at, :departure_at, :distance, presence: true
  
  validate :should_not_be_same_route
  
  default_scope     ->                       { where.not(destination_station_id: nil, source_station_id: nil)}
  scope :get_route, -> (source, destination) { where(source_station_id: source, destination_station_id: destination) }
  
  private

  def should_not_be_same_route
    if (source_station == destination_station)
      errors.add(:base, "source and destination can't be same")
    end
  end

end
