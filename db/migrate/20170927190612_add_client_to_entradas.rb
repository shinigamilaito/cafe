class AddClientToEntradas < ActiveRecord::Migration[5.0]
  def change
    add_reference :entradas, :client, foreign_key: true
  end
end
