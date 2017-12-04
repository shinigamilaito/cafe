class AddObservacionesToSalidas < ActiveRecord::Migration[5.0]
  def change
    add_column :salida_procesos, :observaciones, :text
    add_column :salida_bodegas, :observaciones, :text
  end
end
