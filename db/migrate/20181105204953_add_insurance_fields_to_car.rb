class AddInsuranceFieldsToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :insurance_month, :integer
    add_column :cars, :insurance_year, :integer
    add_column :cars, :insurance_company, :string
  end
end
