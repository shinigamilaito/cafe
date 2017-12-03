class LineItemSalidaBodegasController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salida_bodega, only: [:create]

  # POST /line_item_salidas
  # POST /line_item_salidas.json  
  def create
    partida = Partida.find(params[:partida_id])
       
    @line_item_salida_bodega = @cart_salida_bodega.line_item_salida_bodegas.find_by_partida_id(partida.id) ||
                        @cart_salida_bodega.line_item_salida_bodegas.build(partida: partida)  
    
    @line_item_salida_bodega.attributes = salida_bodega_params
    
    respond_to do |format|
      if @line_item_salida_bodega.save
        format.html { redirect_to @line_item_salida_bodega.cliente }
        format.js
        format.json { render :show, status: :created, location: @line_item_salida_bodega }
      else
        format.html { render :new }
        format.js { render :not_create }
        format.json { render json: @line_item_salida_bodega.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def salida_bodega_params
      params.require(:line_item_salida_bodega).permit(:total_sacos, :total_bolsas, 
        :total_kilogramos_netos)
    end
end
