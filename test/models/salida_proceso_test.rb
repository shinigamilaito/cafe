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
  test "los tipos de cafe deben ser iguales" do
    salida_proceso = salida_procesos(:one)
    
    assert_not(salida_proceso.same_type_coffee)
    assert_equal(salida_proceso.errors[:base], ['Los tipos de cafés son diferentes.'])
  end
end
