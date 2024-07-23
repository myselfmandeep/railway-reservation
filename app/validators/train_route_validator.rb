class TrainRouteValidator < ActiveModel::Validator
  def validate(record)
    if (record.source_station == record.destination_station)
      record.errors.add(:base, "source and destination can't be same")
    end
  end
end