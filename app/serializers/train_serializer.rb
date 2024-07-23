class TrainSerializer < ActiveModel::Serializer
  attributes :name, :uniq_number, :category

  has_many :schedules
end
