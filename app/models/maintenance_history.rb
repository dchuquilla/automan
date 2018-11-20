class MaintenanceHistory < ApplicationRecord
  belongs_to :car
  belongs_to :user_car_setting
  has_many :cost_details, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  
  validates :car_id, :estimated_km, :maintenance_type, :scheduled_date, :status, :user_car_setting_id, presence: true

  validates :provider, :cost, presence: true, if: [Proc.new { |m| m.status == 'Completado' }]

  before_validation do
    check_car_setting
  end

  def check_car_setting
    user_car_setting = UserCarSetting.find_or_create_by(maintenance_type: self.maintenance_type, car_id: self.car_id)
    self.user_car_setting_id = user_car_setting.id
  end

  def time_remaining
    current_km_prox = self.car.current_km_estimated
    km_remaining = self.estimated_km - current_km_prox
    ((km_remaining / self.car.week_km) * 7).round # in days
  end

  def time_remaining_class
    if time_remaining <= 0
      "alert"
    elsif time_remaining <= 7
      "warning"
    else
      "success"
    end
  end

  def has_completed?
    MaintenanceHistory.where("maintenance_type = ? AND status = 'Completado'", self.maintenance_type).count > 0
  end

end
