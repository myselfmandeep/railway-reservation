class AddColumnAbbrToStations < ActiveRecord::Migration[7.1]
  def change
    add_column :stations, :abbr, :string
  end
end
