class CreateProcessResults < ActiveRecord::Migration[5.0]
  def change
    create_table :process_results do |t|
      t.belongs_to :salida_proceso, foreign_key: true
      t.string :date
      t.string :rango_lote
      t.string :fecha_inicio
      t.string :fecha_termino
      t.string :humedad
      t.string :fecha_inicio_humedad
      t.string :fecha_termino_humedad
      t.integer :equivalencia_sacos, limit: 8, default: 69
      t.string :total_kilos_totales
      t.string :total_porcentaje
      t.string :total_sacos
      t.string :total_kilos_sacos
      t.string :rendimiento
      t.text :observaciones

      t.timestamps
    end
  end
end
