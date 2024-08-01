class AddChatsMessagesTable < ActiveRecord::Migration[7.1]
  def change

    create_table :chats, id: :uuid do |t|
      t.integer :participants, array: true, default: []

    end
    
    create_table :messages do |t|
      t.text :body
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :chat,   null: false, foreign_key: true, type: :uuid
    end
    
  end
end
