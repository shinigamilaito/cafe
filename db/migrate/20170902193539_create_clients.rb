class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :organization

      t.timestamps
    end
  end
end
