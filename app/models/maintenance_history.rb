class MaintenanceHistory < ApplicationRecord
  belongs_to :car
  belongs_to :user_car_setting
  has_many :cost_details, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  
  validates :car_id, :estimated_km, :maintenance_type, :scheduled_date, :status, :user_car_setting_id, presence: true

  validates :provider, :cost, presence: true,
                    if: [Proc.new { |m| m.status == 'Completado' }]

  before_validation do
    check_car_setting
  end

  def check_car_setting
    user_car_setting = UserCarSetting.find_or_create_by(maintenance_type: self.maintenance_type, car_id: self.car_id)
    self.user_car_setting_id = user_car_setting.id
  end

end
