class Owner < ApplicationRecord
  belongs_to :user
	has_many :cars

  validates :name, :lastname, :agreement, :email, :cel_phone, presence: true
end
