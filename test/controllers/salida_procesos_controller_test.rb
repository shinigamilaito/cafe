require 'test_helper'

class SalidaProcesosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salida_proceso = salida_procesos(:one)
  end

  test "should get index" do
    get salida_procesos_url
    assert_response :success
  end

  test "should get new" do
    get new_salida_proceso_url
    assert_response :success
  end

  test "should create salida_proceso" do    
    sacos = 12
    bolsas = 12
    kilogramos_netos = 12
    
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

  test "should get edit" do
    get edit_salida_proceso_url(@salida_proceso)
    assert_response :success
  end

  test "should destroy salida_proceso" do
    assert_difference('SalidaProceso.count', -1) do
      delete salida_proceso_url(@salida_proceso)
    end

    assert_redirected_to salida_procesos_url
  end
end
