require 'test_helper'

class CartSalidaProcesosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_salida = cart_salida_procesos(:one)
  end

  test "should destroy cart_salida" do
    post line_item_salida_procesos_url, params: { partida_id: partidas(:one).id, 
      line_item_salida_proceso: {total_sacos: 1, total_bolsas: 1, total_kilogramos_netos:8.00}}
    @cart_salida = CartSalidaProceso.find(session[:cart_salida_proceso_id])
    @client = @cart_salida.cliente
    
    assert_difference('CartSalidaProceso.count', -1) do
      delete cart_salida_proceso_url(@cart_salida)
    end

    assert_redirected_to client_url(@client)
  end
  
end
