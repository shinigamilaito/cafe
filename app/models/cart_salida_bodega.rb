# == Schema Information
#
# Table name: cart_salida_bodegas
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CartSalidaBodega < ApplicationRecord
  include CartSalidas
  
  has_many :line_item_salida_bodegas, dependent: :destroy
  
  def total_sacos
    CartSalidas.total_sacos(line_item_salida_bodegas)
  end
  
  def total_bolsas
    CartSalidas.total_bolsas(line_item_salida_bodegas)
  end
  
  def total_kilogramos_netos
    CartSalidas.total_kilogramos_netos(line_item_salida_bodegas)    
  end
  
  # Todas la salidas en un cart son del mismo cliente
  def cliente
    CartSalidas.cliente(line_item_salida_bodegas)
  end
  
  def tipo_cafe
    CartSalidas.tipo_cafe(line_item_salida_bodegas)
  end
end
