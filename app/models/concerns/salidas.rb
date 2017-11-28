module Salidas
  
  def add_total_from_cart_salida(cart_salida)
    self.total_sacos = cart_salida.total_sacos
    self.total_bolsas = cart_salida.total_bolsas
    self.total_kilogramos_netos = cart_salida.total_kilogramos_netos
    self.tipo_cafe = cart_salida.tipo_cafe
  end
  
end