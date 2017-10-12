class AddKilogramosNetosToLineItemSalida < ActiveRecord::Migration[5.0]
  def change
    add_column :line_item_salidas, :total_kilogramos_netos, :integer, default: 0
  end
end
