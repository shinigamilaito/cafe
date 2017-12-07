class CreateMermas < ActiveRecord::Migration[5.0]
  def change
    create_table :mermas do |t|
      t.integer :merma_type, default: 0
      t.date :date_dry
      t.string :quantity
      t.text :observations
      t.references :partida, foreign_key: true

      t.timestamps
    end
  end
end
