require 'test_helper'

class EntradasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entrada = Entrada.new({
      date: Time.now,
      numero_entrada: 5,
      numero_entrada_cliente: 2,
      driver: 'driver',
      client_id: clients(:pedro).id,
      entregado_por: 'entragado por'     
    })
    
    @partida = Partida.new({
      kilogramos_brutos: 100.00,
      numero_sacos: 5,
      numero_bolsas: 5,
      tara: 5 + 5*0.100,
      kilogramos_netos: 50.00,
      humedad: 15.00,
      type_coffee_id: type_coffees(:pergamino).id,
      calidad_cafe: 'Oro'      
    })
  end

  test "should get index" do
    get entradas_url
    assert_response :success
    
    assert_select ".row .col-sm-12 h1.title-md", 1
    assert_select ".pull-right a.btn-ghost.btn-primary", 1
    assert_select "h1.text-uppercase", I18n.t('entradas.index.title')
    assert_select ".table-responsive table.table", 1
    assert_select "table tbody tr", minimum: 2
    
  end

  test "should get new" do
    get new_entrada_url
    assert_response :success
    
    assert_select "h1.title-md", I18n.t('entradas.new.title')
    assert_select "div#formulario-entradas", 1
    assert_select "a.add_fields", 1
    assert_select "div#partidas", 1
    assert_select "div.nested-fields", 1
    assert_select "input[type=text].numero-bolsas", 1
    assert_select "input[type=text].numero-sacos", 1
    assert_select "input[type=text].tara", 1
    assert_select "input[type=text].kilogramos-brutos", 1
    assert_select "input[type=text].kilogramos-netos", 1
    assert_select "div#datetimepicker_for_date", 1
    assert_select "input[type=text]#entrada_date", 1
    assert_select "input[type=text].humedad", 1
    assert_select "input[type=hidden]#entrada_id", 1
    assert_select "select#entrada_client_id", 1
    assert_select "input[type=number]#entrada_numero_entrada_cliente", 1
    
  end

  test "should create entrada" do        
    assert_difference('Entrada.count') do
      post entradas_url, params: {  entrada: {
          numero_entrada: @entrada.numero_entrada, 
          numero_entrada_cliente: @entrada.numero_entrada_cliente, 
          date: @entrada.date, 
          entregado_por: @entrada.entregado_por, 
          client_id: @entrada.client_id,
          driver: @entrada.driver, 
          partidas_attributes: {
            "0"=>{
              kilogramos_brutos: @partida.kilogramos_brutos, 
              numero_sacos: @partida.numero_sacos, 
              numero_bolsas: @partida.numero_bolsas, 
              tara: @partida.tara, 
              kilogramos_netos: @partida.kilogramos_netos, 
              humedad: @partida.humedad, 
              type_coffee_id: @partida.type_coffee_id, 
              calidad_cafe: @partida.calidad_cafe,              
              observaciones: @partida.observaciones, 
              _destroy: "false"}
          }
        }
      }
    end

    assert_redirected_to entrada_url(Entrada.last)
  end

  test "should show entrada" do
    @entrada = Entrada.last
    
    get entrada_url(@entrada)
    assert_response :success
    assert_select "h1.title-md", I18n.t('entradas.show.title')
    assert_select "ul.nav.nav-tabs.nav-tabs-shop li a", 'Información Entrada'
    assert_select "div.tab-content div.tab-pane#specifications", 1
    assert_select "table.table", 2
    assert_select "table tbody tr", minimum: 11
  end

  test "should get edit" do
    @entrada = entradas(:three)
    
    get edit_entrada_url(@entrada)
    assert_response :success
    assert_select "h1.title-md", I18n.t('entradas.edit.title')
    assert_select "div#formulario-entradas", 1
    assert_select "a.add_fields", 1
    assert_select "div#partidas", 1
    assert_select "div.nested-fields", minimum: 1
    assert_select "input[type=text].numero-bolsas", minimum: 1
    assert_select "input[type=text].numero-sacos", minimum: 1
    assert_select "input[type=text].tara", minimum: 1
    assert_select "input[type=text].kilogramos-brutos", minimum: 1
    assert_select "input[type=text].kilogramos-netos", minimum: 1
    assert_select "div#datetimepicker_for_date", minimum: 1
    assert_select "input[type=text]#entrada_date", minimum: 1
    assert_select "input[type=text].humedad", minimum: 1
    assert_select "input[type=hidden]#entrada_id", minimum: 1
    assert_select "select#entrada_client_id", minimum: 1
    assert_select "input[type=number]#entrada_numero_entrada_cliente", minimum: 1
  end
  
  test "not should get edit for entradas con partidas que han salido a proceso" do
    @entrada = entradas(:one)
    
    get edit_entrada_url(@entrada)
    assert_redirected_to entradas_url
  end

  test "should update entrada" do
    @entrada = Entrada.last
    @partida = @entrada.partidas.first
    
    patch entrada_url(@entrada), params: { entrada: {
      numero_entrada: @entrada.numero_entrada, 
      numero_entrada_cliente: @entrada.numero_entrada_cliente, 
      date: @entrada.date, 
      entregado_por: @entrada.entregado_por, 
      client_id: @entrada.client_id,
      driver: @entrada.driver, 
      partidas_attributes: {
        "0"=>{
          kilogramos_brutos: @partida.kilogramos_brutos, 
          numero_sacos: @partida.numero_sacos, 
          numero_bolsas: @partida.numero_bolsas, 
          tara: @partida.tara, 
          kilogramos_netos: @partida.kilogramos_netos, 
          humedad: @partida.humedad, 
          type_coffee_id: @partida.type_coffee_id, 
          calidad_cafe: @partida.calidad_cafe, 
          observaciones: @partida.observaciones, 
          _destroy: "false",
          id: @partida.id
          }
      }
      }
    }
    
    assert_redirected_to entrada_url(@entrada)
  end

  test "should destroy entrada" do
    @entrada = entradas(:sin_salida_proceso)
    
    assert_difference('Entrada.count', 0) do
      delete entrada_url(@entrada)
    end

    assert(Entrada.find(@entrada.id).delete_logical)
    assert_redirected_to entradas_url
  end
  
  test "not should destroy entrada para partidas que han salido a proceso" do
    @entrada = entradas(:one)
    assert_difference('Entrada.count', 0) do
      delete entrada_url(@entrada)
    end

    assert_not(Entrada.last.delete_logical)
    assert_redirected_to entradas_url
  end
  
  test "should get reporte" do
    @entrada = Entrada.last
    
    get reporte_entrada_url(@entrada)
    assert File.exist?("#{Rails.root}/reports/entradas.pdf")
    assert_response :success
    assert File.delete("#{Rails.root}/reports/entradas.pdf")
  end
  
  test "should obtain numero_entrada_cliente for new entrada via json" do    
    get numero_entrada_cliente_entradas_url, params: { id: "", idCliente: clients(:pedro).id },
    xhr: true
    
    assert_response :success
  end
  
  test "should obtain numero_entrada_cliente for edit entrada via json" do    
    get numero_entrada_cliente_entradas_url, params: { id: entradas(:one).id, idCliente: clients(:pedro).id },
    xhr: true
    
    assert_response :success
  end
  
end
