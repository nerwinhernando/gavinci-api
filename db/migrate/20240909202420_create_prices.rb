class CreatePrices < ActiveRecord::Migration[7.2]
  def change
    create_table :prices do |t|
      t.references :station, null: false, foreign_key: true
      t.references :fuel_type, null: false, foreign_key: true
      t.decimal :amount, precision: 5, scale: 3, null: false
      t.references :user, foreign_key: true
      t.boolean :is_confirmed, default: false

      t.timestamps
    end
    add_index :prices, [:station_id, :fuel_type_id, :created_at]
  end
end
