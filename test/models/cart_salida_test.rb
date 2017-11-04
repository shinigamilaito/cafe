# == Schema Information
#
# Table name: cart_salidas
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CartSalidaTest < ActiveSupport::TestCase
  def setup 
    @cart_salida = cart_salidas(:one)
  end
  
  test "debe obtener el total de sacos correcto" do
    assert_equal(@cart_salida.total_sacos, 53)
  end
  
  test "debe obtener el total de bolsas correcto" do
    assert_equal(@cart_salida.total_bolsas, 28)
  end
  
  test "debe obtener el total de kilogramos netos correcto" do
    assert_equal(@cart_salida.total_kilogramos_netos, '69.31')
  end
  
  test "debe obtener el cliente correcto" do
    assert_equal(@cart_salida.cliente, clients(:juan))
  end
end
