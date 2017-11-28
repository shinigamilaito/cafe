# == Schema Information
#
# Table name: cart_salida_procesos
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CartSalidaProceso < ApplicationRecord
  has_many :line_item_salida_procesos, dependent: :destroy
  
  def total_sacos
    self.line_item_salida_procesos.map(&:total_sacos).sum
  end
  
  def total_bolsas
    self.line_item_salida_procesos.map(&:total_bolsas).sum
  end
  
  def total_kilogramos_netos
    total = BigDecimal("0")
    self.line_item_salida_procesos.each do |line_item_salida|
      total += BigDecimal(line_item_salida.total_kilogramos_netos)      
    end
        
    total.to_s    
  end
  
  # Todas la salidas en un cart son del mismo cliente
  def cliente
    return self.line_item_salida_procesos.first.partida.entrada.client
  end
  
  def tipo_cafe
    return self.line_item_salida_procesos.first.partida.type_coffee.name
  end
  
end
