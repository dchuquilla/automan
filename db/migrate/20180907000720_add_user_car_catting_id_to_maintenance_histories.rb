class AddUserCarCattingIdToMaintenanceHistories < ActiveRecord::Migration[5.2]
  def change
    add_reference :maintenance_histories, :user_car_setting, foreign_key: true
  end
end
