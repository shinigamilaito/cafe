module Salidas
  
  # Verifica que los item de la salida tengan el mismo tipo de cafe
  def Salidas.same_type_coffee(line_item_salidas)
    type_coffee = line_item_salidas.first.partida.type_coffee
    line_item_salidas.each do |salida|
      unless type_coffee.eql?(salida.partida.type_coffee)        
        return false
      end
    end
    
    return true
  end
  
  def add_total_from_cart_salida(cart_salida)
    self.total_sacos = cart_salida.total_sacos
    self.total_bolsas = cart_salida.total_bolsas
    self.total_kilogramos_netos = cart_salida.total_kilogramos_netos
    self.tipo_cafe = cart_salida.tipo_cafe
  end
  
end