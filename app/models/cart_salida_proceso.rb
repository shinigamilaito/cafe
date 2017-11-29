# == Schema Information
#
# Table name: cart_salida_procesos
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Entidad que almacena las salidas a proceso de manera temporal

class CartSalidaProceso < ApplicationRecord
  include CartSalidas
  
  has_many :line_item_salida_procesos, dependent: :destroy
  
  def total_sacos
    CartSalidas.total_sacos(line_item_salida_procesos)
  end
  
  def total_bolsas
    CartSalidas.total_bolsas(line_item_salida_procesos)
  end
  
  def total_kilogramos_netos
    CartSalidas.total_kilogramos_netos(line_item_salida_procesos)    
  end
  
  # Todas la salidas en un cart son del mismo cliente
  def cliente
    CartSalidas.cliente(line_item_salida_procesos)
  end
  
  def tipo_cafe
    CartSalidas.tipo_cafe(line_item_salida_procesos)
  end
  
end
