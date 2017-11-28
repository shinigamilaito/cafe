class LineItemSalidasController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salidas, only: [:create]

  # POST /line_item_salidas
  # POST /line_item_salidas.json  
  def create
    partida = Partida.find(params[:partida_id])
       
    @line_item_salida = @cart_salida.line_item_salidas.find_by_partida_id(partida.id) ||
                        @cart_salida.line_item_salidas.build(partida: partida)  
    
    @line_item_salida.attributes = salida_proceso_params
    
    respond_to do |format|
      if @line_item_salida.save
        format.html { redirect_to @line_item_salida.cliente }
        format.js
        format.json { render :show, status: :created, location: @line_item_salida }
      else
        format.html { render :new }
        format.js { render :not_create }
        format.json { render json: @line_item_salida.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def salida_proceso_params
      params.require(:line_item_salida).permit(:total_sacos, :total_bolsas, 
        :total_kilogramos_netos)
    end
end
