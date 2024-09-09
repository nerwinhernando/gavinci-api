class CreateFuelTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :fuel_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
