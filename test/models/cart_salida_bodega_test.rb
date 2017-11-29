# == Schema Information
#
# Table name: cart_salida_bodegas
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CartSalidaBodegaTest < ActiveSupport::TestCase
  def setup 
    @cart_salida = cart_salida_bodegas(:one)
  end
  
  test "debe obtener el total de sacos correcto" do
    assert_equal(@cart_salida.total_sacos, 10)
  end
  
  test "debe obtener el total de bolsas correcto" do
    assert_equal(@cart_salida.total_bolsas, 10)
  end
  
  test "debe obtener el total de kilogramos netos correcto" do
    assert_equal(@cart_salida.total_kilogramos_netos, '10.0')
  end
  
  test "debe obtener el cliente correcto" do
    assert_equal(@cart_salida.cliente, clients(:pedro))
  end
end
