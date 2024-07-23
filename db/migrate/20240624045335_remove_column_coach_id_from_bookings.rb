class RemoveColumnCoachIdFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bookings, :coach, foreign_key: true, index: false
  end
end
