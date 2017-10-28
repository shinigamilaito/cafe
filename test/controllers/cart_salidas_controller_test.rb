require 'test_helper'

class CartSalidasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_salida = cart_salidas(:one)
  end

  test "should destroy cart_salida" do
    post line_item_salidas_url, params: { partida_id: partidas(:one).id, 
      line_item_salida: {total_sacos: 10, total_bolsas: 23, total_kilogramos_netos:23.45}}
    @cart_salida = CartSalida.find(session[:cart_salida_id])
    @client = @cart_salida.cliente
    
    assert_difference('CartSalida.count', -1) do
      delete cart_salida_url(@cart_salida)
    end

    assert_redirected_to client_url(@client)
  end
  
end
