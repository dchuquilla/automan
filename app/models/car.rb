class Car < ApplicationRecord
  belongs_to :owner
  has_many :maintenance_histories
  validates :plate, :brand, :model, :current_km, :car_type, :week_km, presence: true
end
