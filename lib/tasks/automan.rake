namespace :automan do
  desc "Add priority for specific maintenance types"
  task :set_priority_maintenances => :environment do
    types_list = ["Cambio de aceite y filtros", "Inspección de frenos", "ABC de Motor", "Cambiar Aceite de Caja", "Cambar Filtro de Combustible", "Alineación y balanceo", "Inspección de líquidos", "Carga de gasolina"]
    bar = RakeProgressbar.new(types_list.length)

    Setting.update_all(priority: nil)
    MaintenanceHistory.update_all(priority: nil)
    UserCarSetting.update_all(priority: nil)
    
    types_list.each do |type|
      Setting.where("maintenance_type = ?", type).update_all(priority: 1)
      MaintenanceHistory.where("maintenance_type = ?", type).update_all(priority: 1)
      UserCarSetting.where("maintenance_type = ?", type).update_all(priority: 1)

      Setting.where("priority IS NULL", type).update_all(priority: 2)
      MaintenanceHistory.where("priority IS NULL", type).update_all(priority: 2)
      UserCarSetting.where("priority IS NULL", type).update_all(priority: 2)
      bar.inc
    end
    bar.finish
  end
end