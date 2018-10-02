class AddKmUpdatedDateToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :km_updated_date, :datetime
  end
end
