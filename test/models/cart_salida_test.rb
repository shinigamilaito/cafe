require 'test_helper'

class CartSalidaTest < ActiveSupport::TestCase
  test "debe obtener el total de sacos correcto" do
    cart_salida = cart_salidas(:one)
    
    assert_equal(cart_salida.total_sacos, 53)
  end
  
  test "debe obtener el total de bolsas correcto" do
    cart_salida = cart_salidas(:one)
    
    assert_equal(cart_salida.total_bolsas, 28)
  end
  
  test "debe obtener el total de kilogramos netos correcto" do
    cart_salida = cart_salidas(:one)
    
    assert_equal(cart_salida.total_kilogramos_netos, '69.31')
  end
end
