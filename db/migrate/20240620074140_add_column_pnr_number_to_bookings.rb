class AddColumnPnrNumberToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :pnr_number, :integer
  end
end