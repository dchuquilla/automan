class Owner < ApplicationRecord
  belongs_to :user
	has_many :cars

  validates :name, :last_name, :email, :cel_phone, presence: true
  validates :agreement_terms, acceptance: true
end
