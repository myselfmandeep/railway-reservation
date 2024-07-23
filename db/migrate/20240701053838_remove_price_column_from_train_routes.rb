class RemovePriceColumnFromTrainRoutes < ActiveRecord::Migration[7.1]
  def change
    remove_column :train_routes, :price, :decimal
  end
end
