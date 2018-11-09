class AddPriorityToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :priority, :integer
    add_column :maintenance_histories, :priority, :integer
    add_column :user_car_settings, :priority, :integer
  end
end
