class ChangeTrainRouteColumnsToDecimals < ActiveRecord::Migration[7.1]
  def up
    change_column :train_routes, :distance, :decimal, precision: 6, scale: 2
    change_column :train_routes, :price, :decimal, precision: 6, scale: 2
    # rename_column :train_routes, :arrived_at, :starts_at # todo
  end

  def down
    change_column :train_routes, :distance, :integer
    change_column :train_routes, :price, :integer
  end
end
