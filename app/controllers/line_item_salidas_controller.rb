class LineItemSalidasController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salidas, only: [:create]
  before_action :set_line_item_salida, only: [:show, :edit, :update, :destroy]

  # GET /line_item_salidas
  # GET /line_item_salidas.json
  def index
    @line_item_salidas = LineItemSalida.all
  end

  # GET /line_item_salidas/1
  # GET /line_item_salidas/1.json
  def show
  end

  # GET /line_item_salidas/new
  def new
    @line_item_salida = LineItemSalida.new
  end

  # GET /line_item_salidas/1/edit
  def edit
  end

  # POST /line_item_salidas
  # POST /line_item_salidas.json  
  def create
    partida = Partida.find(params[:partida_id])
    
    @line_item_salida = @cart_salida.line_item_salidas.find_by_partida_id(partida.id) ||
                        @cart_salida.line_item_salidas.build(partida: partida)  
    
    if params[:sacos_salida].present?
      @line_item_salida.total_sacos = params[:sacos_salida][:total]
    elsif params[:bolsas_salida].present?
      @line_item_salida.total_bolsas = params[:bolsas_salida][:total]
    end
    
    respond_to do |format|
      if @line_item_salida.save
        format.html { redirect_to @line_item_salida.partida.entrada.client }
        format.js
        format.json { render :show, status: :created, location: @line_item_salida }
      else
        format.html { render :new }
        format.json { render json: @line_item_salida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_item_salidas/1
  # PATCH/PUT /line_item_salidas/1.json
  def update
    respond_to do |format|
      if @line_item_salida.update(line_item_salida_params)
        format.html { redirect_to @line_item_salida, notice: 'Line item salida was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item_salida }
      else
        format.html { render :edit }
        format.json { render json: @line_item_salida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_item_salidas/1
  # DELETE /line_item_salidas/1.json
  def destroy
    @line_item_salida.destroy
    respond_to do |format|
      format.html { redirect_to line_item_salidas_url, notice: 'Line item salida was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item_salida
      @line_item_salida = LineItemSalida.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_salida_params
      params.require(:line_item_salida).permit(:partida_id)
    end
end
