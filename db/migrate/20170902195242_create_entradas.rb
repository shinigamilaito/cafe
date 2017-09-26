class CreateEntradas < ActiveRecord::Migration[5.0]
  def change
    create_table :entradas do |t|
      t.datetime :date
      t.integer :numero_entrada, limit: 8
      t.string :driver
      t.string :entregado_por
      t.integer :total_partidas, limit: 8, default: 1

      t.timestamps
    end
  end
end
