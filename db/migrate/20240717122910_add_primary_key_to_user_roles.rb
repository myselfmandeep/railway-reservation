class AddPrimaryKeyToUserRoles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_roles, :id, :primary_key
  end
end
