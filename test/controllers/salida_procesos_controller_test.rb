require 'test_helper'

class SalidaProcesosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salida_proceso = salida_procesos(:one)
  end

  test "should get index" do
    get salida_procesos_url
    assert_response :success
  end

  test "should create salida_proceso" do    
    sacos = 8
    bolsas = 2
    kilogramos_netos = 1.13
    
    post line_item_salidas_url, params: { 
      partida_id: partidas(:three).id,
      line_item_salida: {
        total_sacos: sacos,
        total_bolsas: bolsas,
        total_kilogramos_netos: kilogramos_netos
      }        
    }
    
    @cart_salida = CartSalida.find(session[:cart_salida_id])
    @client = @cart_salida.cliente
    
    assert_difference('SalidaProceso.count') do
      post salida_procesos_url, params: { salida_proceso: { 
          tipo_cafe: @salida_proceso.tipo_cafe, 
          total_bolsas: @salida_proceso.total_bolsas,
          total_kilogramos_netos: @salida_proceso.total_kilogramos_netos, 
          total_sacos: @salida_proceso.total_sacos } }
    end

    assert_redirected_to SalidaProceso.last
  end

  test "should show salida_proceso" do
    get salida_proceso_url(@salida_proceso)
    assert_response :success
  end

end
