class ChangeArrayTypeInTrains < ActiveRecord::Migration[7.1]
  def change
    remove_column :trains, :coaches, :integer, array: true
    add_column    :trains, :coaches, :integer, array: true, default: []
  end
end
