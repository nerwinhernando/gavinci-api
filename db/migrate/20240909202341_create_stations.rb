class CreateStations < ActiveRecord::Migration[7.2]
  def change
    create_table :stations do |t|
      t.string :name, null: false
      t.string :brand
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.boolean :is_open, default: true

      t.timestamps
    end
    add_index :stations, [:latitude, :longitude]
  end
end
