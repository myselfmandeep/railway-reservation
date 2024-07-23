class AddColumnsToTrainsAndTrainRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :trains, :category, :string

    add_reference :train_routes, :source_station, foreign_key: {to_table: :stations }
    add_reference :train_routes, :destination_station, foreign_key: {to_table: :stations }
    add_column    :train_routes, :distance, :integer
    add_column    :train_routes, :price   , :integer
  end
end
