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
  def setup 
    @line_item_salida = line_item_salidas(:one)
  end
  
  test "pertenece a una partida" do
    assert(@line_item_salida.partida)
  end
  
  test "pertenece a un carrito de salida" do
    assert(@line_item_salida.cart_salida)
  end
  
  test "verifica se valide total de sacos no exceda el disponible" do
    assert_not(@line_item_salida.check_total_sacos_is_valid)
    assert_equal(@line_item_salida.errors[:total_sacos], ['La cantidad disponible es 1 sacos'])
    assert_not(@line_item_salida.check_total_bolsas_is_valid)
    assert_equal(@line_item_salida.errors[:total_bolsas], ['La cantidad disponible es 1 bolsas'])
    assert_not(@line_item_salida.check_total_kilogramos_netos_is_valid)
    assert_equal(@line_item_salida.errors[:total_kilogramos_netos], ['La cantidad disponible es 8.89 kilogramos'])
  end
  
  test "obtiene el cliente correcto" do
    assert_equal(@line_item_salida.cliente, clients(:pedro))
  end
  
end
