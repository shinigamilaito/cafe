require 'test_helper'

class MermasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_salida = cart_salida_bodegas(:one)
  end

  test "should create merma" do
    assert_difference('Merma.count') do
      post mermas_url, params: { merma: { 
          partida_id: partidas(:three).id, 
          quantity: '1.00', 
          date_dry: Time.now } 
        }, xhr: true
    end

    assert_response :success
  end
  
end
