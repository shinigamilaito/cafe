class AddSalidaProcesoToLineItemSalidaProceso < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_item_salida_procesos, :salida_proceso, foreign_key: true
  end
end
