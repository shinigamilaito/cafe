require 'test_helper'

class SalidaProcesosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salida_proceso = salida_procesos(:one)
  end

  test "should get index" do
    get salida_procesos_url
    assert_response :success
    
    assert_select ".row .col-sm-12 h1.title-md", 1
    assert_select "h1.text-uppercase", I18n.t('salida_procesos.index.title')
    assert_select ".table-responsive table.table", 1
    assert_select "table tbody tr", minimum: 2
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
    
    assert_select "h1.title-md", I18n.t('salida_procesos.show.title')
    assert_select "ul.nav.nav-tabs.nav-tabs-shop li a", 'Información Salida'
    assert_select "div.tab-content div.tab-pane#specifications", 1
    assert_select "div.btn-group a", 1
    assert_select "table.table.table-striped", minimum: 1
  end

end
