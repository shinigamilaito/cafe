class CreateLineItemSalidaProcesos < ActiveRecord::Migration[5.0]
  def change
    create_table :line_item_salida_procesos do |t|
      t.references :partida, foreign_key: true
      t.belongs_to :cart_salida_proceso, foreign_key: true
      t.integer :total_sacos, limit:  8, default: 0
      t.integer :total_bolsas, limit:  8, default: 0

      t.timestamps
    end
  end
end
