require 'test_helper'

class EntradasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entrada = Entrada.new({
      date: Time.now,
      numero_entrada: 3,
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
  end

  test "should get new" do
    get new_entrada_url
    assert_response :success
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
  end

  test "should get edit" do
    @entrada = Entrada.last
    
    get edit_entrada_url(@entrada)
    assert_response :success
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
    @entrada = Entrada.last
    assert_difference('Entrada.count', 0) do
      delete entrada_url(@entrada)
    end

    assert_redirected_to entradas_url
  end
end
