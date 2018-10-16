class AddGallonsToMaintenanceHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenance_histories, :gallons, :decimal
  end
end
