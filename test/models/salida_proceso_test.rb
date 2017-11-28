# == Schema Information
#
# Table name: salida_procesos
#
#  id                     :integer          not null, primary key
#  client_id              :integer
#  tipo_cafe              :string
#  total_sacos            :integer          default(0)
#  total_bolsas           :integer          default(0)
#  total_kilogramos_netos :string           default("0.00")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class SalidaProcesoTest < ActiveSupport::TestCase
  def setup
    @salida_proceso = salida_procesos(:one)
  end
      
  test "pertenece a un cliente y tiene muchos line_item_salidas" do
    assert(@salida_proceso.client)
    assert(@salida_proceso.line_item_salida_procesos)
  end
  
  test "agrega los line item desde un cart_salida" do
    cart_salida = cart_salida_procesos(:two)
    salida_proceso = salida_procesos(:two)
    salida_proceso.add_line_item_salidas_from_cart_salida(cart_salida)
    
    assert_equal(salida_proceso.line_item_salida_procesos, cart_salida.line_item_salida_procesos)
    salida_proceso.line_item_salida_procesos.each do |salida|
      assert_nil(salida.cart_salida_proceso_id)
    end 
  end
  
  test "añade el total de sacos,bolsas, kilogramos netos y el tipo de cafe" do
    cart_salida = cart_salida_procesos(:two)
    salida_proceso = salida_procesos(:two)
    
    salida_proceso.add_total_from_cart_salida(cart_salida)
    
    assert_equal(salida_proceso.total_sacos, cart_salida.total_sacos)
    assert_equal(salida_proceso.total_bolsas, cart_salida.total_bolsas)
    assert_equal(salida_proceso.total_kilogramos_netos, cart_salida.total_kilogramos_netos)
    assert_equal(salida_proceso.tipo_cafe, cart_salida.tipo_cafe)
  end
  
  test "obtener las entradas afectadas" do
    assert_equal(@salida_proceso.entradas_afectadas.to_a, [entradas(:one)])
  end
  
  test "obtener line item salidas para entrada" do
    assert_equal(@salida_proceso.line_item_salidas_para_entrada(entradas(:one)).to_a, 
    [line_item_salida_procesos(:four), line_item_salida_procesos(:no_valido_cafe_distinto)]
    )
  end
  
  test "los tipos de cafe deben ser iguales" do
    assert_not(@salida_proceso.same_type_coffee)
    assert_equal(@salida_proceso.errors[:base], ['Los tipos de cafés son diferentes.'])
  end
end
