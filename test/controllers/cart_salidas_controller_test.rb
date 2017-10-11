require 'test_helper'

class CartSalidasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_salida = cart_salidas(:one)
  end

  test "should get index" do
    get cart_salidas_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_salida_url
    assert_response :success
  end

  test "should create cart_salida" do
    assert_difference('CartSalida.count') do
      post cart_salidas_url, params: { cart_salida: {  } }
    end

    assert_redirected_to cart_salida_url(CartSalida.last)
  end

  test "should show cart_salida" do
    get cart_salida_url(@cart_salida)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_salida_url(@cart_salida)
    assert_response :success
  end

  test "should update cart_salida" do
    patch cart_salida_url(@cart_salida), params: { cart_salida: {  } }
    assert_redirected_to cart_salida_url(@cart_salida)
  end

  test "should destroy cart_salida" do
    post line_item_salidas_url, params: { partida_id: partidas(:one).id }
    @cart_salida = CartSalida.find(session[:cart_salida_id])
    @client = @cart_salida.line_item_salidas.first.partida.entrada.client
    
    assert_difference('CartSalida.count', -1) do
      delete cart_salida_url(@cart_salida)
    end

    assert_redirected_to client_url(@client)
  end
end
