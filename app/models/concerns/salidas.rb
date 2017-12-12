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
  
  def asignar_numero_salida
    ultima_salida = class_name.order("created_at DESC").first
    if ultima_salida
      self.numero_salida = ultima_salida.numero_salida + 1
    else
      self.numero_salida = 1
    end    
  end
  
  def asignar_numero_salida_por_cliente
    ultima_salida = class_name.where("client_id = ?", self.client_id).order("created_at DESC").first
     if ultima_salida
      self.numero_salida_cliente = ultima_salida.numero_salida_cliente + 1
    else
      self.numero_salida_cliente = 1
    end    
  end
  
  
end