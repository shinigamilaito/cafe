class AddNumeroEntradaClienteToEntradas < ActiveRecord::Migration[5.0]
  def change
    add_column :entradas, :numero_entrada_cliente, :integer, limit: 8, default: 0
  end
end
