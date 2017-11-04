require 'test_helper'

class LineItemSalidasControllerTest < ActionDispatch::IntegrationTest
  
  test "should create line_item_salida" do   
    sacos = 1
    bolsas = 1
    kilogramos_netos = 4.56
    assert_difference('LineItemSalida.count') do
      post line_item_salidas_url, params: { 
        partida_id: partidas(:one).id,
        line_item_salida: {
          total_sacos: sacos,
          total_bolsas: bolsas,
          total_kilogramos_netos: kilogramos_netos
        }        
      }
    end

    assert_equal(LineItemSalida.last.total_sacos, 1)
    assert_equal(LineItemSalida.last.total_bolsas, 1)
    assert_equal(LineItemSalida.last.total_kilogramos_netos, '4.56')
    follow_redirect!
    assert_select 'h1', 'Datos del Cliente'
    assert_select 'ul.nav li a', 'Información Personal'
    assert_select 'ul.nav li a', /Entradas/
  end

end
