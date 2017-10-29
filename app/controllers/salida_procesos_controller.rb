class SalidaProcesosController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salidas, only: [:create]
  before_action :set_salida_proceso, only: [:show]

  # GET /salida_procesos
  # GET /salida_procesos.json
  def index
    @salida_procesos = SalidaProceso.order('created_at DESC')
  end

  # GET /salida_procesos/1
  # GET /salida_procesos/1.json
  def show
  end

  # POST /salida_procesos
  # POST /salida_procesos.json
  def create
    @salida_proceso = SalidaProceso.new
    @salida_proceso.client = @cart_salida.cliente
    @salida_proceso.add_total_from_cart_salida(@cart_salida)
    @salida_proceso.add_line_item_salidas_from_cart_salida(@cart_salida)

    respond_to do |format|
      if @salida_proceso.save
        CartSalida.destroy(session[:cart_salida_id])
        session[:cart_salida_id] = nil
        flash[:success] = I18n.t('.salida_procesos.created')        
        format.html { redirect_to @salida_proceso }
        format.json { render :show, status: :created, location: @salida_proceso }
      else
        flash[:error] = I18n.t('.salida_procesos.not_created')        
        format.html { redirect_to @cart_salida.cliente }
        format.json { render json: @salida_proceso.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salida_proceso
      @salida_proceso = SalidaProceso.find(params[:id])
    end

end
