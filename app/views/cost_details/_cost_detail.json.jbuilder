json.extract! cost_detail, :id, :cost_type, :cost, :provider, :maintenance_history_id, :created_at, :updated_at
json.url cost_detail_url(cost_detail, format: :json)
