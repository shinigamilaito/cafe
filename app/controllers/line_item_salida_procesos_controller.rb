class LineItemSalidaProcesosController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salida_proceso, only: [:create]

  # POST /line_item_salidas
  # POST /line_item_salidas.json  
  def create
    partida = Partida.find(params[:partida_id])
       
    @line_item_salida_proceso = @cart_salida_proceso.line_item_salida_procesos.find_by_partida_id(partida.id) ||
                        @cart_salida_proceso.line_item_salida_procesos.build(partida: partida)  
    
    @line_item_salida_proceso.attributes = salida_proceso_params
    
    respond_to do |format|
      if @line_item_salida_proceso.save
        format.html { redirect_to @line_item_salida_proceso.cliente }
        format.js
        format.json { render :show, status: :created, location: @line_item_salida_proceso }
      else
        format.html { render :new }
        format.js { render :not_create }
        format.json { render json: @line_item_salida_proceso.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def salida_proceso_params
      params.require(:line_item_salida_proceso).permit(:total_sacos, :total_bolsas, 
        :total_kilogramos_netos)
    end
end
