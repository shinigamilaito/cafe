module CurrentCartSalidas
  
  private
  
    def set_cart_salida_proceso
      @cart_salida_proceso = CartSalidaProceso.find(session[:cart_salida_proceso_id])
    rescue ActiveRecord::RecordNotFound
      @cart_salida_proceso = CartSalidaProceso.create
      session[:cart_salida_proceso_id] = @cart_salida_proceso.id      
    end
    
    def set_cart_salida_bodega
      @cart_salida_bodega = CartSalidaBodega.find(session[:cart_salida_bodega_id])
    rescue ActiveRecord::RecordNotFound
      @cart_salida_bodega = CartSalidaBodega.create
      session[:cart_salida_bodega_id] = @cart_salida_bodega.id      
    end
end