class CreateTrains < ActiveRecord::Migration[7.1]
  def change
    create_table :trains do |t|
      t.string     :name
      t.integer    :uniq_number
      t.references :source_station     , null: false, foreign_key: {to_table: :stations}
      t.references :destination_station, null: false, foreign_key: {to_table: :stations}
      t.string     :start_at
      t.string     :end_at
      t.integer    :coaches, type: :array, default: []

      t.timestamps
    end
  end
end
