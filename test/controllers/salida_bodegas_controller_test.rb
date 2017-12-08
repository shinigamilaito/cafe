require 'test_helper'

class SalidaBodegasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salida_bodega = salida_bodegas(:one)
  end

  test "should get index" do
    get salida_bodegas_url
    assert_response :success
    
    assert_select ".row .col-sm-12 h1.title-md", 1
    assert_select "h1.text-uppercase", I18n.t('salidas.index.title_bodega')
    assert_select ".table-responsive table.table", 1
    assert_select "table tbody tr", minimum: 1
  end

  test "should create salida_bodega" do    
    sacos = 8
    bolsas = 2
    kilogramos_netos = 1.13
    
    post line_item_salida_bodegas_url, params: { 
      partida_id: partidas(:three).id,
      line_item_salida_bodega: {
        total_sacos: sacos,
        total_bolsas: bolsas,
        total_kilogramos_netos: kilogramos_netos
      }        
    }
    
    @cart_salida = CartSalidaBodega.find(session[:cart_salida_bodega_id])
    @client = @cart_salida.cliente
    
    assert_difference('SalidaBodega.count') do
      post salida_bodegas_url, params: { salida_bodega: { 
          name_driver: 'name driver',
          name_person: 'name person',
          tipo_cafe: @salida_bodega.tipo_cafe, 
          total_bolsas: @salida_bodega.total_bolsas,
          total_kilogramos_netos: @salida_bodega.total_kilogramos_netos, 
          total_sacos: @salida_bodega.total_sacos } }
    end

    assert_redirected_to SalidaBodega.last
  end

  test "should show salida_bodega" do
    get salida_bodega_url(@salida_bodega)
    
    assert_response :success
    
    assert_select "h1.title-md", "#{I18n.t('salidas.show.title_bodega')}: 00001"
    assert_select "ul.nav.nav-tabs.nav-tabs-shop li a", 'Información Salida'
    assert_select "div.tab-content div.tab-pane#specifications", 1
    assert_select "div.btn-group a", minimum: 1
    assert_select "table.table.table-striped", minimum: 1
  end
  
  test "should get reporte" do
    @salida_bodega = SalidaBodega.last
    
    get reporte_salida_bodega_url(@salida_bodega)
    assert File.exist?("#{Rails.root}/reports/entradas.pdf")
    assert_response :success
    assert File.delete("#{Rails.root}/reports/entradas.pdf")
  end

end
