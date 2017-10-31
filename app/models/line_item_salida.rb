# == Schema Information
#
# Table name: line_item_salidas
#
#  id                     :integer          not null, primary key
#  partida_id             :integer
#  cart_salida_id         :integer
#  total_sacos            :integer          default(0)
#  total_bolsas           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  total_kilogramos_netos :string           default("0.0")
#  salida_proceso_id      :integer
#

class LineItemSalida < ApplicationRecord
  belongs_to :salida_proceso, optional: true
  belongs_to :partida
  belongs_to :cart_salida, optional: true
  
  validates :partida_id, presence: true
  validates :total_sacos, :total_bolsas, :total_kilogramos_netos, presence: true
  validates :total_sacos, :total_bolsas, numericality: { only_integer: true }, format:{with: /\A\d+\z/ }  
  validates :total_kilogramos_netos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  
  def cliente
    self.partida.entrada.client
  end
end
