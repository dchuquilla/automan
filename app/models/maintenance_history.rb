class MaintenanceHistory < ApplicationRecord
  belongs_to :car
  has_many :cost_details
end
