class AddCostalillasPartidas < ActiveRecord::Migration[5.0]
  def change
    add_column :partidas, :numero_costalillas, :bigint
  end
end
