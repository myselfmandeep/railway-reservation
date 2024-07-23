class ChangeBookingSeatsToArrayTrue < ActiveRecord::Migration[7.1]
  def change
    # execute <<-SQL
    #   ALTER TABLE bookings
    #   ALTER COLUMN seats SET DATA TYPE integer[] USING array[seats],
    #   ALTER COLUMN seats SET DEFAULT '{}',
    #   ALTER COLUMN seats SET NOT NULL
    # SQL
    remove_column :bookings, :seats, :integer
    add_column    :bookings, :seats, :integer, array: true, default: []
  end

  # def down
  #   execute <<-SQL
  #     ALTER TABLE bookings
  #     ALTER COLUMN seats DROP DEFAULT,
  #     ALTER COLUMN seats SET DATA TYPE integer USING (seats[1]),
  #     ALTER COLUMN seats DROP NOT NULL
  #   SQL
  # end
end
