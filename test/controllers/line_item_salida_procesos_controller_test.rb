require 'test_helper'

class LineItemSalidaProcesosControllerTest < ActionDispatch::IntegrationTest
  
  test "should create line_item_salida" do   
    sacos = 1
    bolsas = 1
    kilogramos_netos = 4.56
    assert_difference('LineItemSalidaProceso.count') do
      post line_item_salida_procesos_url, params: { 
        partida_id: partidas(:one).id,
        line_item_salida_proceso: {
          total_sacos: sacos,
          total_bolsas: bolsas,
          total_kilogramos_netos: kilogramos_netos
        }        
      }
    end

    assert_equal(LineItemSalidaProceso.last.total_sacos, 1)
    assert_equal(LineItemSalidaProceso.last.total_bolsas, 1)
    assert_equal(LineItemSalidaProceso.last.total_kilogramos_netos, '4.56')
    follow_redirect!
    assert_select 'h1', 'Datos del Cliente'
    assert_select 'ul.nav li a', 'Información Personal'
    assert_select 'ul.nav li a', /Entradas/
  end

end
