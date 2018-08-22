class Car < ApplicationRecord
  belongs_to :owner
  has_many :maintenance_histories
end
