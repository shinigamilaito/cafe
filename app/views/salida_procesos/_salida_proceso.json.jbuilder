json.extract! salida_proceso, :id, :client_id, :tipo_cafe, :total_sacos, :total_bolsas, :total_kilogramos_netos, :created_at, :updated_at
json.url salida_proceso_url(salida_proceso, format: :json)
