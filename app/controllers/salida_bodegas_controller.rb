class SalidaBodegasController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salida_bodega, only: [:create]
  before_action :set_salida_bodega, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_salida_bodega

  # GET /salida_bodegas
  # GET /salida_bodegas.json
  def index
    @salida_bodegas = SalidaBodega.order('created_at DESC').page(params[:page])
  end

  # GET /salida_bodegas/1
  # GET /salida_bodegas/1.json
  def show
  end

  # POST /salida_bodegas
  # POST /salida_bodegas.json
  def create
    @salida_bodega = SalidaBodega.new(salida_bodega_params)
    @salida_bodega.client = @cart_salida_bodega.cliente
    @salida_bodega.add_total_from_cart_salida(@cart_salida_bodega)
    @salida_bodega.add_line_item_salidas_from_cart_salida(@cart_salida_bodega)

    respond_to do |format|
      if @salida_bodega.save
        CartSalidaBodega.destroy(session[:cart_salida_bodega_id])
        session[:cart_salida_bodega_id] = nil
        flash[:success] = I18n.t('salidas.created')        
        format.html { redirect_to @salida_bodega }
        format.json { render :show, status: :created, location: @salida_bodega }
      else
        flash[:error] = I18n.t('salidas.not_created')        
        format.html { redirect_to @cart_salida_bodega.cliente }
        format.json { render json: @salida_bodega.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salida_bodega
      @salida_bodega = SalidaBodega.find(params[:id])
    end
    
    def salida_bodega_params
      params.require(:salida_bodega).permit(:name_driver, :name_person)
    end
    
    def invalid_salida_bodega
      logger.error "Attempt to access invalid salida bodega #{params[:id]}"
      flash[:danger] = 'Salida de Bodega no valida'
      redirect_to root_url
    end

end
