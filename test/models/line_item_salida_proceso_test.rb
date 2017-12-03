# == Schema Information
#
# Table name: line_item_salida_procesos
#
#  id                     :integer          not null, primary key
#  partida_id             :integer
#  cart_salida_proceso_id :integer
#  total_sacos            :integer          default(0)
#  total_bolsas           :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  total_kilogramos_netos :string           default("0.00")
#  salida_proceso_id      :integer
#

require 'test_helper'

class LineItemSalidaProcesoTest < ActiveSupport::TestCase
  def setup 
    @line_item_salida = LineItemSalidaProceso.new({
      partida: partidas(:one),
      cart_salida_proceso: cart_salida_procesos(:one),
      total_sacos: 58,
      total_bolsas: 80,
      total_kilogramos_netos: 145.67
     })
  end
  
  test "pertenece a una partida" do
    assert(@line_item_salida.partida)
  end
  
  test "pertenece a un carrito de salida" do
    assert(@line_item_salida.cart_salida_proceso)
  end
  
  test "verifica se valide total de sacos no exceda el disponible" do
    assert_not(@line_item_salida.check_total_sacos_is_valid)
    assert_equal(@line_item_salida.errors[:total_sacos], ['La cantidad disponible es 17 sacos'])
    assert_not(@line_item_salida.check_total_bolsas_is_valid)
    assert_equal(@line_item_salida.errors[:total_bolsas], ['La cantidad disponible es 58 bolsas'])
    assert_not(@line_item_salida.check_total_kilogramos_netos_is_valid)
    assert_equal(@line_item_salida.errors[:total_kilogramos_netos], ['La cantidad disponible es 80.03 kilogramos'])
  end
  
  test "obtiene el cliente correcto" do
    assert_equal(@line_item_salida.cliente, clients(:pedro))
  end
  
end
