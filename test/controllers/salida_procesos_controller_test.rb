require 'test_helper'

class SalidaProcesosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salida_proceso = salida_procesos(:one)
  end

  test "should get index" do
    get salida_procesos_url
    assert_response :success
    
    assert_select ".row .col-sm-12 h1.title-md", 1
    assert_select "h1.text-uppercase", I18n.t('salidas.index.title_proceso')
    assert_select ".table-responsive table.table", 1
    assert_select "table tbody tr", minimum: 1
  end

  test "should create salida_proceso" do    
    sacos = 8
    bolsas = 2
    kilogramos_netos = 1.13
    
    post line_item_salida_procesos_url, params: { 
      partida_id: partidas(:three).id,
      line_item_salida_proceso: {
        total_sacos: sacos,
        total_bolsas: bolsas,
        total_kilogramos_netos: kilogramos_netos
      }        
    }
    
    @cart_salida = CartSalidaProceso.find(session[:cart_salida_proceso_id])
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
    
    assert_select "h1.title-md",  "#{I18n.t('salidas.show.title_proceso')}: 00001"
    assert_select "ul.nav.nav-tabs.nav-tabs-shop li a", 'Información Salida'
    assert_select "div.tab-content div.tab-pane#specifications", 1
    assert_select "div.btn-group a", minimum: 1
    assert_select "table.table.table-striped", minimum: 1
  end
  
  test "should get reporte" do
    @salida_proceso = SalidaProceso.last
    
    get reporte_salida_proceso_url(@salida_proceso)
    assert File.exist?("#{Rails.root}/reports/salidas_proceso.pdf")
    assert_response :success
    assert File.delete("#{Rails.root}/reports/salidas_proceso.pdf")
  end

end
