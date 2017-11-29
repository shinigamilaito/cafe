module CartSalidas
  
  def CartSalidas.total_sacos(line_item_salidas)
    return line_item_salidas.map(&:total_sacos).sum
  end
  
  def CartSalidas.total_bolsas(line_item_salidas)
    return line_item_salidas.map(&:total_bolsas).sum
  end
  
  def CartSalidas.total_kilogramos_netos(line_item_salidas)
    total = BigDecimal("0")
    line_item_salidas.each do |line_item_salida|
      total += BigDecimal(line_item_salida.total_kilogramos_netos)      
    end
        
    return total.to_s    
  end
  
  # Todas la salidas en un cart son del mismo cliente
  def CartSalidas.cliente(line_item_salidas)
    return line_item_salidas.first.partida.entrada.client
  end
  
  def CartSalidas.tipo_cafe(line_item_salidas)
    return line_item_salidas.first.partida.type_coffee.name
  end
  
end