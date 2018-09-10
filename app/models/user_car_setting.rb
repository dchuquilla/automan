class UserCarSetting < ApplicationRecord
  belongs_to :car
  has_many :maintenance_histories
end
