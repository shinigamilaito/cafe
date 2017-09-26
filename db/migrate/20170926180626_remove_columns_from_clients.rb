class RemoveColumnsFromClients < ActiveRecord::Migration[5.0]
  def change
    remove_column :clients, :first_name, :string
    remove_column :clients, :last_name, :string
    rename_column :clients, :name, :legal_representative
  end
end
