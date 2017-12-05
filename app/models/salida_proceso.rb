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
#

class SalidaProceso < ApplicationRecord
  include Salidas
  
  belongs_to :client
  has_many :line_item_salida_procesos, dependent: :destroy
  has_many :partidas, through: :line_item_salida_procesos
  has_many :entradas, through: :partidas
  
  validate :same_type_coffee
  
  def add_line_item_salidas_from_cart_salida(cart_salida)
    cart_salida.line_item_salida_procesos.each do |item|
      item.cart_salida_proceso_id = nil
      line_item_salida_procesos << item      
    end
  end
    
  def entradas_afectadas
    entradas
  end
  
  def line_item_salidas_para_entrada(entrada)
    entradas_afectadas.where(id: entrada.id).first.partidas_a_proceso      
  end
  
  # Verifica que los item de la salida tengan el mismo tipo de cafe
  def same_type_coffee
    unless Salidas.same_type_coffee(line_item_salida_procesos)
      errors.add(:base, 'Los tipos de cafés son diferentes.')
      return false
    end
  end
end
