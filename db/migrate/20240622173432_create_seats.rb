class CreateSeats < ActiveRecord::Migration[7.1]
  def change
    create_table :seats do |t|
      t.integer    :number
      t.string     :berth
      t.string     :position
      t.references :coach, null: false, foreign_key: true

      t.timestamps
    end
  end
end
