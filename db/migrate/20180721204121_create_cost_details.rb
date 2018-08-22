class CreateCostDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :cost_details do |t|
      t.string :cost_type
      t.decimal :cost
      t.text :provider
      t.references :maintenance_history, foreign_key: true

      t.timestamps
    end
  end
end
