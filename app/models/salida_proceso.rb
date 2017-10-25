class SalidaProceso < ApplicationRecord
  belongs_to :client
  has_many :line_item_salidas, dependent: :destroy
  
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
end
