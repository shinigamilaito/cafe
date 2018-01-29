# == Schema Information
#
# Table name: process_results
#
#  id                  :integer          not null, primary key
#  salida_proceso_id   :integer
#  date                :string
#  rango_lote          :string
#  fecha_inicio        :string
#  fecha_termino       :string
#  humedad             :string
#  hora_inicio         :string
#  hora_termino        :string
#  equivalencia_sacos  :integer          default(69)
#  total_kilos_totales :string
#  total_porcentaje    :string
#  total_sacos         :string
#  total_kilos_sacos   :string
#  rendimiento         :string
#  observaciones       :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ProcessResult < ApplicationRecord
    
  has_many :qualities, dependent: :destroy, inverse_of: :process_result
  accepts_nested_attributes_for :qualities, allow_destroy: true
  
  belongs_to :salida_proceso  
  
  validates :date, :humedad, :hora_inicio, :hora_termino, presence: true
  
  validates :total_kilos_totales, numericality: true
  validates :total_porcentaje, numericality: true
  validates :total_sacos, numericality: true
  validates :total_kilos_sacos, numericality: true
      
  def colocar_kilos_totales
    kilos_totales_arr = self.qualities.map do |quality|
      BigDecimal.new(quality.kilos_totales)
    end
    
    self.total_kilos_totales = kilos_totales_arr.sum.to_s
  end
  
  def colocar_porcentaje
    porcentajes_totales_arr = self.qualities.map do |quality|
      BigDecimal.new(quality.percentage)
    end
    
    self.total_porcentaje = porcentajes_totales_arr.sum.to_s
  end
  
  def colocar_sacos
    sacos_totales_arr = self.qualities.map do |quality|
      BigDecimal.new(quality.sacos)
    end
    
    self.total_sacos = sacos_totales_arr.sum.to_s
  end
  
  def colocar_kilos_sacos
    kilos_sacos_totales_arr = self.qualities.map do |quality|
      BigDecimal.new(quality.kilos_sacos)
    end
    
    self.total_kilos_sacos = kilos_sacos_totales_arr.sum.to_s
  end
end
