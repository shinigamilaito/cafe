json.extract! client, :id, :name, :first_name, :last_name, :address, :organization, :created_at, :updated_at
json.url client_url(client, format: :json)
