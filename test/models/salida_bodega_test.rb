# == Schema Information
#
# Table name: salida_bodegas
#
#  id                     :integer          not null, primary key
#  name_driver            :string
#  name_person            :string
#  client_id              :integer
#  tipo_cafe              :string
#  total_sacos            :integer
#  total_bolsas           :integer
#  total_kilogramos_netos :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  observaciones          :text
#  numero_salida          :integer          default(0)
#  numero_salida_cliente  :integer          default(0)
#

require 'test_helper'

class SalidaBodegaTest < ActiveSupport::TestCase
  def setup   
    @salida = new_salida
    @salida.partidas << partidas(:one)
  end
  
  def new_salida
		SalidaBodega.new(
			name_driver: 'XXXX',
			name_person: 'ZZZZ',
      client: clients(:pedro),   		      
			tipo_cafe: 'Pergamino',
   		total_sacos: 10,
   		total_bolsas: 10,
      total_kilogramos_netos: "10.0",
      numero_salida: 1,
      numero_salida_cliente: 1
		)
  end
      
  test "pertenece a un cliente y tiene muchos line_item_salidas" do
    salida_bodega = salida_bodegas(:one)
    
    assert(salida_bodega.client)
    assert(salida_bodega.line_item_salida_bodegas)
  end
  
  test "agrega los line item desde un cart_salida" do
    cart_salida = cart_salida_bodegas(:one)
    salida_bodega = SalidaBodega.new
    salida_bodega.add_line_item_salidas_from_cart_salida(cart_salida)
    
    assert_equal(salida_bodega.line_item_salida_bodegas, cart_salida.line_item_salida_bodegas)
    salida_bodega.line_item_salida_bodegas.each do |salida|
      assert_nil(salida.cart_salida_bodega_id)
    end 
  end
  
  test "añade el total de sacos,bolsas, kilogramos netos y el tipo de cafe" do
    cart_salida = cart_salida_bodegas(:one)
    salida_bodega = SalidaBodega.new
    
    salida_bodega.add_total_from_cart_salida(cart_salida)
    
    assert_equal(salida_bodega.total_sacos, cart_salida.total_sacos)
    assert_equal(salida_bodega.total_bolsas, cart_salida.total_bolsas)
    assert_equal(salida_bodega.total_kilogramos_netos, cart_salida.total_kilogramos_netos)
    assert_equal(salida_bodega.tipo_cafe, cart_salida.tipo_cafe)
  end
  
  test "obtener las entradas afectadas" do
    salida_bodega = salida_bodegas(:one)
    
    assert_equal(salida_bodega.entradas_afectadas.to_a, [entradas(:two)])
  end
  
  test "obtener line item salidas para entrada" do
    salida_bodega = salida_bodegas(:one)
    
    assert_equal(salida_bodega.line_item_salidas_para_entrada(entradas(:two)).to_a, 
    [line_item_salida_bodegas(:one)]
    )
  end
  
  test "los tipos de cafe deben ser iguales" do
    salida_bodega = salida_bodegas(:one)
    line_item_salida_bodega = LineItemSalidaBodega.new({
        partida: partidas(:one),
        total_sacos: 1,
        total_bolsas: 1,
        total_kilogramos_netos: 1      
      })
    
    salida_bodega.line_item_salida_bodegas << line_item_salida_bodega
    
    assert_not(salida_bodega.same_type_coffee)    
    assert_equal(salida_bodega.errors[:base], ['Los tipos de cafés son diferentes.'])
  end
  
  test "numero salida" do
    last_salida = SalidaBodega.last.numero_salida   
    @salida.save    
    assert @salida.numero_salida, last_salida + 1
       
  end
  
  test "numero salida por cliente" do
    last_salida_cliente = SalidaBodega.last.numero_salida_cliente
    @salida.save
    assert @salida.numero_salida_cliente, last_salida_cliente + 1
  end
end
