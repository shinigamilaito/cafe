class AddDestroyedToEntradas < ActiveRecord::Migration[5.0]
  def change
    add_column :entradas, :delete_logical, :boolean, default: false
  end
end
