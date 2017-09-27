class RemoveClientIdFromPartidas < ActiveRecord::Migration[5.0]
  def change
    remove_reference :partidas, :client, foreign_key: true
  end
end
