class SalidaProcesosController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salidas, only: [:create]
  before_action :set_salida_proceso, only: [:show, :edit, :update, :destroy]

  # GET /salida_procesos
  # GET /salida_procesos.json
  def index
    @salida_procesos = SalidaProceso.order('created_at DESC')
  end

  # GET /salida_procesos/1
  # GET /salida_procesos/1.json
  def show
  end

  # GET /salida_procesos/new
  def new
    @salida_proceso = SalidaProceso.new
  end

  # GET /salida_procesos/1/edit
  def edit
  end

  # POST /salida_procesos
  # POST /salida_procesos.json
  def create
    @salida_proceso = SalidaProceso.new(salida_proceso_params)
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

  # DELETE /salida_procesos/1
  # DELETE /salida_procesos/1.json
  def destroy
    @salida_proceso.destroy
    respond_to do |format|
      format.html { redirect_to salida_procesos_url, notice: 'Salida proceso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salida_proceso
      @salida_proceso = SalidaProceso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def salida_proceso_params      
#      params.require(:salida_proceso).permit(:tipo_cafe, :total_sacos, :total_bolsas, :total_kilogramos_netos)
    end
end
