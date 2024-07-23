class CreatePaymentsTable < ActiveRecord::Migration[7.1]
  def change
    enable_extension "plpgsql"

    create_table :payments, id: :uuid do |t|
      t.decimal    :paid_amount,         precision: 6, scale: 2
      t.decimal    :refund_amount,       precision: 6, scale: 2
      t.decimal    :cancelation_charges, precision: 6, scale: 2

      t.bigint     :transaction_id, null: false
      t.string     :mode

      t.references :user,     null: false, foreign_key: true
      # t.references :booking, null: false, foreign_key: true

      t.timestamps
    end

    add_index :payments, :transaction_id, unique: true
  end
end
