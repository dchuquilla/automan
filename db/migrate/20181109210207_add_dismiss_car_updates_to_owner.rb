class AddDismissCarUpdatesToOwner < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :dismiss_car_updates, :boolean
  end
end
