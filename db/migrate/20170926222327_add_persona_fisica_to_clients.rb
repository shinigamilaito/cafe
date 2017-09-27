class AddPersonaFisicaToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :persona_fisica, :boolean, default: false
  end
end
