class CreateTypeCoffees < ActiveRecord::Migration[5.0]
  def change
    create_table :type_coffees do |t|
      t.string :name

      t.timestamps
    end
  end
end
