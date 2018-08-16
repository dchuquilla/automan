class AddMaintenanceTypeToMaintenanceHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :maintenance_histories, :maintenance_type, :string
  end
end
