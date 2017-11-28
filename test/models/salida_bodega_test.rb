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
#

require 'test_helper'

class SalidaBodegaTest < ActiveSupport::TestCase
  def setup
    @salida_bodega = salida_bodegas(:one)
  end
      
#  test "pertenece a un cliente y tiene muchos line_item_salidas_bodega" do
#    assert(@salida_proceso.client)
#    assert(@salida_proceso.line_item_salidas_bodegas)
#  end
#  
#  test "agrega los line item desde un cart_salida" do
#    cart_salida = cart_salida_bodegas(:one)
#    salida_bodega = salida_bodegas(:one)
#    salida_bodega.add_line_item_salidas_from_cart_salida(cart_salida)
#    
#    assert_equal(salida_bodega.line_item_salida_bodegas, cart_salida.line_item_salida_bodegas)
#    salida_bodega.line_item_salida_bodegas.each do |salida|
#      assert_nil(salida.cart_salida_bodega_id)
#    end 
#  end
#  
#  test "añade el total de sacos,bolsas, kilogramos netos y el tipo de cafe" do
#    cart_salida = cart_salida_bodegas(:two)
#    salida_bodega = salida_bodegas(:two)
#    
#    salida_bodega.add_total_from_cart_salida(cart_salida)
#    
#    assert_equal(salida_bodega.total_sacos, cart_salida.total_sacos)
#    assert_equal(salida_bodega.total_bolsas, cart_salida.total_bolsas)
#    assert_equal(salida_bodega.total_kilogramos_netos, cart_salida.total_kilogramos_netos)
#    assert_equal(salida_bodega.tipo_cafe, cart_salida.tipo_cafe)
#  end
#  
#  test "obtener las entradas afectadas" do
#    assert_equal(@salida_bodega.entradas_afectadas.to_a, [entradas(:one)])
#  end
#  
#  test "obtener line item salidas para entrada" do
#    assert_equal(@salida_bodega.line_item_salidas_para_entrada(entradas(:one)).to_a, 
#    [line_item_salida_bodegas(:four), line_item_salida_bodegas(:no_valido_cafe_distinto)]
#    )
#  end
#  
#  test "los tipos de cafe deben ser iguales" do
#    assert_not(@salida_bodega.same_type_coffee)
#    assert_equal(@salida_bodega.errors[:base], ['Los tipos de cafés son diferentes.'])
#  end
end
