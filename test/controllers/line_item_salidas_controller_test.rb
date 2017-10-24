require 'test_helper'

class LineItemSalidasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item_salida = line_item_salidas(:one)
  end

  test "should get index" do
    get line_item_salidas_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_salida_url
    assert_response :success
  end

  test "should create line_item_salida" do   
    sacos = 8
    bolsas = 10
    kilogramos_netos = 34.56
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

    assert_equal(LineItemSalida.last.total_sacos, 8)
    assert_equal(LineItemSalida.last.total_bolsas, 10)
    assert_equal(LineItemSalida.last.total_kilogramos_netos, '34.56')
    follow_redirect!
    assert_select 'h1', 'Datos del Cliente'
    assert_select 'ul.nav li a', 'Información Personal'
    assert_select 'ul.nav li a', /Entradas/
  end

  test "should show line_item_salida" do
    get line_item_salida_url(@line_item_salida)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_salida_url(@line_item_salida)
    assert_response :success
  end

  test "should update line_item_salida" do
    patch line_item_salida_url(@line_item_salida), params: { line_item_salida: { cart_salida_id: @line_item_salida.cart_salida_id, partida_id: @line_item_salida.partida_id } }
    assert_redirected_to line_item_salida_url(@line_item_salida)
  end

  test "should destroy line_item_salida" do
    assert_difference('LineItemSalida.count', -1) do
      delete line_item_salida_url(@line_item_salida)
    end

    assert_redirected_to line_item_salidas_url
  end
  
end
