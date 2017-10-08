class AddIsHistoricalToTypeCoffee < ActiveRecord::Migration[5.0]
  def change
    add_column :type_coffees, :is_historical, :boolean, default: false
  end
end
