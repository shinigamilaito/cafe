module CurrentCartSalidas
  
  private
  
    def set_cart_salidas
      @cart_salida = CartSalida.find(session[:cart_salida_id])
    rescue ActiveRecord::RecordNotFound
      @cart_salida = CartSalida.create
      session[:cart_salida_id] = @cart_salida.id      
    end
end