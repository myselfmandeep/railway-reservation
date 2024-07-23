class StationSerializer < ActiveModel::Serializer
  attributes :name, :city

  has_many :schedules
end
