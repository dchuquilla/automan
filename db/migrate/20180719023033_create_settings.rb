class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :car_age
      t.integer :km_max
      t.integer :km_min
      t.integer :month_max
      t.integer :month_min
      t.string :car_type

      t.timestamps
    end
  end
end
