class MaintenanceHistory < ApplicationRecord
  belongs_to :car
  belongs_to :user_car_setting
  has_many :cost_details

  before_save :check_car_setting

  validates :car_id, :estimated_km, :maintenance_type, :scheduled_date, :status, :user_car_setting_id, presence: true

  def check_car_setting
    user_car_setting = UserCarSetting.find_or_create_by(maintenance_type: self.maintenance_type, car_id: self.car_id)
    self.user_car_setting_id = user_car_setting.id
  end

end
