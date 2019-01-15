class AddTypeIdentificadorToPartidas < ActiveRecord::Migration[5.0]
  def change
    add_column :partidas, :identificador_with_format, :string
  end
end
