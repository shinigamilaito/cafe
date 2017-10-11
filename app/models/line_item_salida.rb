class LineItemSalida < ApplicationRecord
  belongs_to :partida
  belongs_to :cart_salida
  
  def total_tara
    valor_tara = self.total_sacos + self.total_bolsas*0.100
    
    return valor_tara
  end
end
