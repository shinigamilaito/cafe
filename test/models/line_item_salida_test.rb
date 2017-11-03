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
#  total_kilogramos_netos :string           default("0.00")
#  salida_proceso_id      :integer
#

require 'test_helper'

class LineItemSalidaTest < ActiveSupport::TestCase
  test "pertenece a una partida" do
    line_item_salida = line_item_salidas(:one)
    assert(line_item_salida.partida)
  end
  
  test "pertenece a un carrito de salida" do
    line_item_salida = line_item_salidas(:one)
    assert(line_item_salida.cart_salida)
  end
  
end
