class AddIsHistoricalToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :is_historical, :boolean, default: false
  end
end
