class ChangeBookingAmountToDecimal < ActiveRecord::Migration[7.1]
  def up
    change_column :bookings, :amount, :decimal, precision: 6, scale: 2
  end

  def down
    change_column :bookings, :amount, :integer
  end
end
