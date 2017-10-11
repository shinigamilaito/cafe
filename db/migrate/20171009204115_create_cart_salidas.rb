class CreateCartSalidas < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_salidas do |t|

      t.timestamps
    end
  end
end
