class CartSalida < ApplicationRecord
  has_many :line_item_salidas, dependent: :destroy
  
  def total_sacos
    self.line_item_salidas.map(&:total_sacos).sum
  end
  
  def total_bolsas
    self.line_item_salidas.map(&:total_bolsas).sum
  end
  
  def total_tara
    total = BigDecimal("0")
    self.line_item_salidas.each do |line_item_salida|
      total += BigDecimal((line_item_salida.total_tara).to_s)      
    end
        
    total.to_s    
  end
  
  def total_kilogramos_netos
    total = BigDecimal("0")
    self.line_item_salidas.each do |line_item_salida|
      total += BigDecimal(line_item_salida.total_kilogramos_netos)      
    end
        
    total.to_s    
  end
  
end
