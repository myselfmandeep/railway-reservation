class AddAccountStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :account_status, :string
  end
end
