class LineItemSalida < ApplicationRecord
  belongs_to :salida_proceso, optional: true
  belongs_to :partida
  belongs_to :cart_salida, optional: true
  
  validates :partida_id, presence: true
  validates :total_sacos, :total_bolsas, :total_kilogramos_netos, presence: true
  validates :total_sacos, :total_bolsas, numericality: { only_integer: true }, format:{with: /\A\d+\z/ }  
  validates :total_kilogramos_netos, allow_blank: true, numericality: {
    greater_than_or_equal_to: 0.01 }
  
  def total_tara    
    valor_tara = self.total_sacos + self.total_bolsas*0.100
    
    return valor_tara
  end
  
  def cliente
    self.partida.entrada.client
  end
end
