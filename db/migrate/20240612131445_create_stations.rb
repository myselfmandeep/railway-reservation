class CreateStations < ActiveRecord::Migration[7.1]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :city
      t.string :location

      t.timestamps
    end
  end
end
