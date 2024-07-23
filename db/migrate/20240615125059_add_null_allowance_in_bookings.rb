class AddNullAllowanceInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column_null :bookings, :train_route_id, false
  end
end
