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

class SalidaProceso < ApplicationRecord
  belongs_to :client
  has_many :line_item_salidas, dependent: :destroy
  
  validate :same_type_coffee
  
  def add_line_item_salidas_from_cart_salida(cart_salida)
    cart_salida.line_item_salidas.each do |item|
      item.cart_salida_id = nil
      line_item_salidas << item      
    end
  end
  
  def add_total_from_cart_salida(cart_salida)
    self.total_sacos = cart_salida.total_sacos
    self.total_bolsas = cart_salida.total_bolsas
    self.total_kilogramos_netos = cart_salida.total_kilogramos_netos
    self.tipo_cafe = cart_salida.tipo_cafe
  end
  
  def entradas_afectadas
    entradas_ids = SalidaProceso.joins(line_item_salidas: {partida: :entrada})
      .where("salida_procesos.id = ?", self.id)
      .select("DISTINCT(entradas.id) AS entrada_id")      
      
    Entrada.where(id: entradas_ids.map(&:entrada_id))
  end
  
  def line_item_salidas_para_entrada(entrada)
    line_item_salida_ids = SalidaProceso.joins(line_item_salidas: {partida: :entrada})
      .where("salida_procesos.id = ? AND entradas.id = ?", self.id, entrada.id)
      .select("line_item_salidas.id AS line_item_salida_id")
      
    LineItemSalida.where(id: line_item_salida_ids.map(&:line_item_salida_id))      
  end
  
  # Verifica que los item de la salida tengan el mismo tipo de cafe
  def same_type_coffee
    type_coffee = line_item_salidas.first.partida.type_coffee
    line_item_salidas.each do |salida|
      unless type_coffee.eql?(salida.partida.type_coffee)
        errors.add(:base, 'Los tipos de cafés son diferentes.')
        return false
      end
    end
  end
end
