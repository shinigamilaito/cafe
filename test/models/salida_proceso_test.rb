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
#  observaciones          :text
#  numero_salida          :integer          default(0)
#  numero_salida_cliente  :integer          default(0)
#

require 'test_helper'

class SalidaProcesoTest < ActiveSupport::TestCase
  def setup
    @salida = new_salida
    @salida.partidas << partidas(:one)
    
  end
  
  def new_salida
		SalidaProceso.new(
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
    @salida_proceso = salida_procesos(:one)
    
    assert(@salida_proceso.client)
    assert(@salida_proceso.line_item_salida_procesos)
  end
  
  test "agrega los line item desde un cart_salida" do
    cart_salida = cart_salida_procesos(:one)
    salida_proceso = SalidaProceso.new
    salida_proceso.add_line_item_salidas_from_cart_salida(cart_salida)
    
    assert_equal(salida_proceso.line_item_salida_procesos, cart_salida.line_item_salida_procesos)
    salida_proceso.line_item_salida_procesos.each do |salida|
      assert_nil(salida.cart_salida_proceso_id)
    end 
  end
  
  test "añade el total de sacos,bolsas, kilogramos netos y el tipo de cafe" do
    cart_salida = cart_salida_procesos(:one)
    salida_proceso = SalidaProceso.new
    
    salida_proceso.add_total_from_cart_salida(cart_salida)
    
    assert_equal(salida_proceso.total_sacos, cart_salida.total_sacos)
    assert_equal(salida_proceso.total_bolsas, cart_salida.total_bolsas)
    assert_equal(salida_proceso.total_kilogramos_netos, cart_salida.total_kilogramos_netos)
    assert_equal(salida_proceso.tipo_cafe, cart_salida.tipo_cafe)
  end
  
  test "obtener las entradas afectadas" do
    @salida_proceso = salida_procesos(:one)
    
    assert_equal(@salida_proceso.entradas_afectadas.to_a, [entradas(:one)])
  end
  
  test "obtener line item salidas para entrada" do
    @salida_proceso = salida_procesos(:one)
    
    assert_equal(@salida_proceso.line_item_salidas_para_entrada(entradas(:one)).to_a, 
    [line_item_salida_procesos(:one)]
    )
  end
  
  test "los tipos de cafe deben ser iguales" do
    @salida_proceso = salida_procesos(:one)
    line_item_salida_proceso = LineItemSalidaProceso.new({
        partida: partidas(:two),
        total_sacos: 1,
        total_bolsas: 1,
        total_kilogramos_netos: 1      
      })
    
    @salida_proceso.line_item_salida_procesos << line_item_salida_proceso
    assert_not(@salida_proceso.same_type_coffee)
    assert_equal(@salida_proceso.errors[:base], ['Los tipos de cafés son diferentes.'])
  end
  
  test "numero salida" do
    last_salida = SalidaProceso.last.numero_salida   
    @salida.save    
    assert @salida.numero_salida, last_salida + 1
       
  end
  
  test "numero salida por cliente" do
    last_salida_cliente = SalidaProceso.last.numero_salida_cliente
    @salida.save
    assert @salida.numero_salida_cliente, last_salida_cliente + 1
  end
  
end
