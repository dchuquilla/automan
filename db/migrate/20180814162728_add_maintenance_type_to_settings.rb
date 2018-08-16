class AddMaintenanceTypeToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :maintenance_type, :string
  end
end
