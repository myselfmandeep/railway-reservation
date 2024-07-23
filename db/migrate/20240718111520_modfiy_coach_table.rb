class ModfiyCoachTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :coaches, :category,    :string
    remove_column :coaches, :slug_name,   :string
    add_column    :coaches, :description, :text
  end
end
