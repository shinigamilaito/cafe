# == Schema Information
#
# Table name: line_item_salida_bodegas
#
#  id                     :integer          not null, primary key
#  partida_id             :integer
#  cart_salida_bodega_id  :integer
#  total_sacos            :integer          default(0)
#  total_bolsas           :integer          default(0)
#  total_kilogramos_netos :string           default("0.00")
#  salida_bodega_id       :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class LineItemSalidaBodega < ApplicationRecord
  include LineItemSalidas
  
  belongs_to :salida_bodega, optional: true
  belongs_to :partida
  belongs_to :cart_salida_bodega, optional: true
  
  validates :partida_id, presence: true
  validates :total_sacos, :total_bolsas, :total_kilogramos_netos, presence: true
  validates :total_sacos, :total_bolsas, numericality: { only_integer: true }, format:{with: /\A\d+\z/ }  
  validates :total_kilogramos_netos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }  
  validate :check_total_sacos_is_valid, :check_total_bolsas_is_valid, :check_total_kilogramos_netos_is_valid
  
end
