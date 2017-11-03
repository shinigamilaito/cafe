class CreateSalidaProcesos < ActiveRecord::Migration[5.0]
  def change
    create_table :salida_procesos do |t|
      t.references :client, foreign_key: true
      t.string :tipo_cafe
      t.integer :total_sacos, limit: 8, default: 0
      t.integer :total_bolsas, limit: 8, default: 0
      t.string :total_kilogramos_netos, default: '0.00'

      t.timestamps
    end
  end
end
