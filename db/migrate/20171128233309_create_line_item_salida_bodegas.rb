class CreateLineItemSalidaBodegas < ActiveRecord::Migration[5.0]
  def change
    create_table :line_item_salida_bodegas do |t|
      t.references :partida, foreign_key: true
      t.references :cart_salida_bodega, foreign_key: true
      t.integer :total_sacos, limit: 8, default: 0
      t.integer :total_bolsas, limit: 8, default: 0
      t.string :total_kilogramos_netos, default: '0.00'
      t.references :salida_bodega, foreign_key: true

      t.timestamps
    end
  end
end
