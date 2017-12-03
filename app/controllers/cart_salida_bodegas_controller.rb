class CartSalidaBodegasController < ApplicationController
  before_action :set_cart_salida, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart_salida

  # DELETE /cart_salidas/1
  # DELETE /cart_salidas/1.json
  def destroy
    if @cart_salida_bodega.id == session[:cart_salida_bodega_id]
      cliente = @cart_salida_bodega.cliente
      @cart_salida_bodega.destroy 
    end
    session[:cart_salida_bodega_id] = nil
    respond_to do |format|
      flash[:success] = 'Salida de la bodega exitosamente cancelada.'
      format.html { redirect_to cliente }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_salida
      @cart_salida_bodega = CartSalidaBodega.find(params[:id])
    end

    def invalid_cart_salida
      logger.error "Attempt to access invalid cart salida #{params[:id]}"
      flash[:danger] = 'Salida de la Bodega no valida'
      redirect_to root_url
    end
end
