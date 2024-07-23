class CreateTableTiers < ActiveRecord::Migration[7.1]
  def change
    create_table :tiers do |t|
      t.string :name
      t.string :short_form
      t.decimal :price_per_km, precision: 6, scale: 2
      
      t.timestamps
    end

    add_reference :coaches, :tier, foreign_key: true
    
  end
end
