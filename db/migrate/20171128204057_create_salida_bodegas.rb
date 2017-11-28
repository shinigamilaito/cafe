class CreateSalidaBodegas < ActiveRecord::Migration[5.0]
  def change
    create_table :salida_bodegas do |t|
      t.string :name_driver
      t.string :name_person
      t.references :client, foreign_key: true
      t.string :tipo_cafe
      t.integer :total_sacos
      t.integer :total_bolsas
      t.string :total_kilogramos_netos

      t.timestamps
    end
  end
end
