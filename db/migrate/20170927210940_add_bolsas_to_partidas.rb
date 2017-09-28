class AddBolsasToPartidas < ActiveRecord::Migration[5.0]
  def change
    add_column :partidas, :numero_bolsas, :integer, limit: 8
    rename_column :partidas, :numero_bultos, :numero_sacos
  end
end
