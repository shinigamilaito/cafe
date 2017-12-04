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
#

# Entidad que registra las salidas de cafe de bodega

class SalidaBodega < ApplicationRecord
  include Salidas
  
  belongs_to :client
  has_many :line_item_salida_bodegas, dependent: :destroy
  
  validates :name_driver, presence: true
  validates :name_person, presence: true
  validate :same_type_coffee
  
  def add_line_item_salidas_from_cart_salida(cart_salida)
    cart_salida.line_item_salida_bodegas.each do |item|
      item.cart_salida_bodega_id = nil
      line_item_salida_bodegas << item      
    end
  end
  
  def entradas_afectadas
    entradas_ids = SalidaBodega.joins(line_item_salida_bodegas: {partida: :entrada})
      .where("salida_bodegas.id = ?", self.id)
      .select("DISTINCT(entradas.id) AS entrada_id")      
      
    Entrada.where(id: entradas_ids.map(&:entrada_id))
  end
  
  def line_item_salidas_para_entrada(entrada)
    line_item_salida_ids = SalidaBodega.joins(line_item_salida_bodegas: {partida: :entrada})
      .where("salida_bodegas.id = ? AND entradas.id = ?", self.id, entrada.id)
      .select("line_item_salida_bodegas.id AS line_item_salida_id")
      
    LineItemSalidaBodega.where(id: line_item_salida_ids.map(&:line_item_salida_id))      
  end
  
  # Verifica que los item de la salida tengan el mismo tipo de cafe
  def same_type_coffee
    unless Salidas.same_type_coffee(line_item_salida_bodegas)
      errors.add(:base, 'Los tipos de cafés son diferentes.')
      return false
    end    
  end
  
end
