class CreateTrainRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :train_routes do |t|
      t.references :train  , null: false, foreign_key: true
      t.references :station, null: false, foreign_key: true
      t.string     :arrived_at
      t.string     :departure_at
      t.boolean    :stop, default: true

      t.timestamps
    end
  end
end
