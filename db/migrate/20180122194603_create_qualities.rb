class CreateQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :qualities do |t|
      t.belongs_to :quality_type, foreign_key: true
      t.belongs_to :process_result, foreign_key: true
      t.string :kilos_totales
      t.string :percentage
      t.integer :sacos
      t.string :kilos_sacos

      t.timestamps
    end
  end
end
