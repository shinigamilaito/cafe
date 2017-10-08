class AddIsHistoricalToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :is_historical, :boolean, default: false
    add_column :clients, :delete_logical, :boolean, default: false
  end
end
