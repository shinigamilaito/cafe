class CreateEntradas < ActiveRecord::Migration[5.0]
  def change
    create_table :entradas do |t|
      t.datetime :date
      t.integer :numero_entrada, limit: 8
      t.string :driver
      t.string :entregado_por

      t.timestamps
    end
  end
end
