class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :plate
      t.string :brand
      t.string :model
      t.decimal :current_km
      t.string :car_type
      t.decimal :week_km
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
