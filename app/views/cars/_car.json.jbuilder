json.extract! car, :id, :plate, :brand, :model, :current_km, :car_type, :week_km, :owner_id, :created_at, :updated_at
json.url car_url(car, format: :json)
