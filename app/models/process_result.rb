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

class ProcessResult < ApplicationRecord
    
  has_many :qualities, dependent: :destroy, inverse_of: :process_result
  accepts_nested_attributes_for :qualities, allow_destroy: true
  
  belongs_to :salida_proceso
end
