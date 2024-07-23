class AddColumnTypeSlugAndModifyTableCoach < ActiveRecord::Migration[7.1]
  def change
    add_column    :coaches, :slug_name, :string
    remove_column :coaches, :seat, :integer
  end
end
