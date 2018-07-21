class CreateMaintenanceHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenance_histories do |t|
      t.string :status
      t.decimal :estimated_km
      t.datetime :scheduled_date
      t.decimal :review_km
      t.datetime :review_date
      t.text :provider
      t.decimal :cost
      t.boolean :notified
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
