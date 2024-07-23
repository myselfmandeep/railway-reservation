class RemoveColumnsFromTrainAndTrainRoutes < ActiveRecord::Migration[7.1]
  def change
    # todo: on rollback it is not implementing the null false constraint
    
    remove_reference :trains, :source_station     , foreign_key: { to_table: :stations }
    remove_reference :trains, :destination_station, foreign_key: { to_table: :stations }
    remove_column    :trains, :start_at, :string
    remove_column    :trains, :end_at  , :string

    remove_reference :train_routes, :station, foreign_key: true
    remove_column    :train_routes, :stop, :boolean
  end
end
