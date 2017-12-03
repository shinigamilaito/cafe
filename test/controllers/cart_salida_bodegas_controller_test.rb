require 'test_helper'

class CartSalidaBodegasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_salida = cart_salida_bodegas(:one)
  end

  test "should destroy cart_salida" do
    post line_item_salida_bodegas_url, params: { partida_id: partidas(:one).id, 
      line_item_salida_bodega: {total_sacos: 1, total_bolsas: 1, total_kilogramos_netos:8.00}}
    @cart_salida = CartSalidaBodega.find(session[:cart_salida_bodega_id])
    @client = @cart_salida.cliente
    
    assert_difference('CartSalidaBodega.count', -1) do
      delete cart_salida_bodega_url(@cart_salida)
    end

    assert_redirected_to client_url(@client)
  end
  
end
