class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer    :seats
      t.integer    :amount
      t.boolean    :confirmed
      t.date       :date
      t.references :train, null: false, foreign_key: true
      t.references :coach, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
