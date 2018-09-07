class CreateUserCarSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_car_settings do |t|
      t.integer :car_id
      t.integer :km_estimated
      t.integer :month_estimated
      t.string :maintenance_type

      t.timestamps
    end
  end
end
