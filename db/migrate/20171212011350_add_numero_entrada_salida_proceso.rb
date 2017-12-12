class AddNumeroEntradaSalidaProceso < ActiveRecord::Migration[5.0]
  def change
    add_column :salida_procesos, :numero_salida, :integer, default: 0
    add_column :salida_procesos, :numero_salida_cliente, :integer, default: 0
  end
end
