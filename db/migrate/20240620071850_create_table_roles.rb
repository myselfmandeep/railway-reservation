class CreateTableRoles < ActiveRecord::Migration[7.1]
  def up
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    create_table :user_roles, id: false do |t|
      t.references :user, null: false
      t.references :role, null: false
    end
  end

  def down
    drop_table :roles
    drop_table :user_roles
  end

end
