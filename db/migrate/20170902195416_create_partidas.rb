class CreatePartidas < ActiveRecord::Migration[5.0]
  def change
    create_table :partidas do |t|
      t.references :entrada, foreign_key: true
      t.string :kilogramos_brutos
      t.integer :numero_bultos, limit: 8
      t.string :tara
      t.string :kilogramos_netos
      t.string :humedad
      t.references :type_coffee, foreign_key: true
      t.string :calidad_cafe
      t.references :client, foreign_key: true
      t.text :observaciones

      t.timestamps
    end
  end
end
