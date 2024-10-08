class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string     :name
      t.integer    :age
      t.string     :gender
      t.string     :berth
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
