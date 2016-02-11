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
  
  test "obtiene el valor de tara" do
    line_item_salida = line_item_salidas(:one)
    
    assert_equal(line_item_salida.total_tara, 8.5)
  end
  
end
