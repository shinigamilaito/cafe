class AddNumeroEntradaSalidaBodega < ActiveRecord::Migration[5.0]
  def change
    add_column :salida_bodegas, :numero_salida, :integer, default: 0
    add_column :salida_bodegas, :numero_salida_cliente, :integer, default: 0
  end
end
