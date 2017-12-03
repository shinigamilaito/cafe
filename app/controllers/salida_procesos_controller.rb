class SalidaProcesosController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salida_proceso, only: [:create]
  before_action :set_salida_proceso, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_salida_proceso

  # GET /salida_procesos
  # GET /salida_procesos.json
  def index
    @salida_procesos = SalidaProceso.order('created_at DESC').page(params[:page])
  end

  # GET /salida_procesos/1
  # GET /salida_procesos/1.json
  def show
  end

  # POST /salida_procesos
  # POST /salida_procesos.json
  def create
    @salida_proceso = SalidaProceso.new
    @salida_proceso.client = @cart_salida_proceso.cliente
    @salida_proceso.add_total_from_cart_salida(@cart_salida_proceso)
    @salida_proceso.add_line_item_salidas_from_cart_salida(@cart_salida_proceso)

    respond_to do |format|
      if @salida_proceso.save
        CartSalidaProceso.destroy(session[:cart_salida_proceso_id])
        session[:cart_salida_proceso_id] = nil
        flash[:success] = I18n.t('salidas.created')        
        format.html { redirect_to @salida_proceso }
        format.json { render :show, status: :created, location: @salida_proceso }
      else
        flash[:error] = I18n.t('salidas.not_created')        
        format.html { redirect_to @cart_salida_proceso.cliente }
        format.json { render json: @salida_proceso.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salida_proceso
      @salida_proceso = SalidaProceso.find(params[:id])
    end
    
    def invalid_salida_proceso
      logger.error "Attempt to access invalid salida proceso #{params[:id]}"
      flash[:danger] = 'Salida a proceso no valida'
      redirect_to root_url
    end

end
