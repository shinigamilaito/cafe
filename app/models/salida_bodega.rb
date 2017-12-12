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

# Entidad que registra las salidas de cafe de bodega

class SalidaBodega < ApplicationRecord
  include Salidas
  
  belongs_to :client
  has_many :line_item_salida_bodegas, dependent: :destroy
  has_many :partidas, through: :line_item_salida_bodegas
  has_many :entradas, through: :partidas
  
  validates :name_driver, presence: true
  validates :name_person, presence: true
  validate :same_type_coffee
  
  before_create :asignar_numero_salida, :asignar_numero_salida_por_cliente
  
  def add_line_item_salidas_from_cart_salida(cart_salida)
    cart_salida.line_item_salida_bodegas.each do |item|
      item.cart_salida_bodega_id = nil
      line_item_salida_bodegas << item      
    end
  end
  
  def entradas_afectadas
    entradas
  end
  
  def line_item_salidas_para_entrada(entrada)
    entradas_afectadas.where(id: entrada.id).first.partidas_retiradas_bodega
  end
  
  # Verifica que los item de la salida tengan el mismo tipo de cafe
  def same_type_coffee
    unless Salidas.same_type_coffee(line_item_salida_bodegas)
      errors.add(:base, 'Los tipos de cafés son diferentes.')
      return false
    end    
  end  
  
  private
  
    def class_name
      SalidaBodega
    end
  
end
