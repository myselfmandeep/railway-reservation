class AddTrainRouteIdToBookingTable < ActiveRecord::Migration[7.1]
  def up
    add_reference    :bookings, :train_route, foreign_key: true
    remove_reference :bookings, :train
  end

  def down
    add_reference    :bookings, :train, foreign_key: true
    remove_reference :bookings, :train_route
  end
  
end
