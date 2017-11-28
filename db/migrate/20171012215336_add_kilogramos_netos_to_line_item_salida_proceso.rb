class AddKilogramosNetosToLineItemSalidaProceso < ActiveRecord::Migration[5.0]
  def change
    add_column :line_item_salida_procesos, :total_kilogramos_netos, :string, default: '0.00'
  end
end
