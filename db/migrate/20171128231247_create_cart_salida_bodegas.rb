class CreateCartSalidaBodegas < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_salida_bodegas do |t|

      t.timestamps
    end
  end
end
