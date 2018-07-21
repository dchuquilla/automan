json.extract! maintenance_history, :id, :status, :estimated_km, :scheduled_date, :review_km, :review_date, :provider, :cost, :notified, :car_id, :created_at, :updated_at
json.url maintenance_history_url(maintenance_history, format: :json)
