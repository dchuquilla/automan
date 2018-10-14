class Car < ApplicationRecord
  belongs_to :owner
  has_many :maintenance_histories, dependent: :destroy
  # Multiple images with ActiveStorage
  has_many_attached :images, dependent: :destroy
  
  validates :plate, :brand, :model, :current_km, :car_type, :week_km, presence: true

  # KM actual estimado usando KM semanal
  def current_km_estimated
    # 1 KM semanal a KM por hora (168)
    # 2 Tiempo transcurrido con el paso de las horas
    self.current_km + ((self.week_km / 168.0) * (((Time.now - self.updated_at) / 1.hour).round)) rescue 0
  end

  def pending_maintenances
    self.maintenance_histories.where(status: "Pendiente")
  end

end
