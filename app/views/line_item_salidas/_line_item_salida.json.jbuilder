json.extract! line_item_salida, :id, :partida_id, :cart_salida_id, :created_at, :updated_at
json.url line_item_salida_url(line_item_salida, format: :json)
