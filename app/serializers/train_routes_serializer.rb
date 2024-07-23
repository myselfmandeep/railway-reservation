class TrainRoutesSerializer < ActiveModel::Serializer
  attributes :arrived_at, :departure_at
  
  belongs_to :train
  belongs_to :source_station
  belongs_to :destination_station
end
