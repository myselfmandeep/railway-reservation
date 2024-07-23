class RemoveColumnsSeatsAndStatusFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :seats, :integer, array: true
    remove_column :bookings, :status, :string
    add_column    :tickets, :status, :string
  end
end
