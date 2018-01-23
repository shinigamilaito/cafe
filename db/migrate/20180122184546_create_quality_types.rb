class CreateQualityTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :quality_types do |t|
      t.string :name
      t.integer :orden, limit: 8, default: 1
      t.boolean :is_to_increment, default: true

      t.timestamps
    end
  end
end
