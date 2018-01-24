# == Schema Information
#
# Table name: process_results
#
#  id                    :integer          not null, primary key
#  salida_proceso_id     :integer
#  date                  :string
#  rango_lote            :string
#  fecha_inicio          :string
#  fecha_termino         :string
#  humedad               :string
#  fecha_inicio_humedad  :string
#  fecha_termino_humedad :string
#  equivalencia_sacos    :integer          default(69)
#  total_kilos_totales   :string
#  total_porcentaje      :string
#  total_sacos           :string
#  total_kilos_sacos     :string
#  rendimiento           :string
#  observaciones         :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class ProcessResultTest < ActiveSupport::TestCase
  def new_process_result
    process_result = ProcessResult.new(
      
    )
    
    process_result.qualities << Quality.new(
      kilos_totales: '100.00',
      percentage: '12',
      sacos: '1',
      kilos_sacos: '69'
    )
    process_result.qualities << Quality.new(
      kilos_totales: '10.50',
      percentage: '7',
      sacos: '3',
      kilos_sacos: '207'
    )
    
    return process_result
  end
  
  test "debe obtener los kilos totales" do
    process_result = new_process_result
    
    assert_equal process_result.colocar_kilos_totales, '110.5'    
  end
  
  test "debe obtener porcentaje total" do
    process_result = new_process_result
    
    assert_equal process_result.colocar_porcentaje, '19.0'    
  end
  
  test "debe obtener total sacos" do
    process_result = new_process_result
    
    assert_equal process_result.colocar_sacos, '4.0'    
  end
  
  test "debe obtener total kilos sacos" do
    process_result = new_process_result
    
    assert_equal process_result.colocar_kilos_sacos, '276.0'    
  end
end
