require 'jasper-bridge/jasper'
class EntradasController < ApplicationController
  include Jasper::Bridge
  before_action :set_entrada, only: [:show, :edit, :update, :destroy, :reporte]
  
  # GET /entradas
  # GET /entradas.json
  def index
    @entradas = Entrada.validas.order("updated_at DESC")
  end

  # GET /entradas/1
  # GET /entradas/1.json
  def show     
  end

  # GET /entradas/new
  def new
    @entrada = Entrada.new
    @entrada.siguiente_numero_entrada
    @entrada.partidas.build
  end

  # GET /entradas/1/edit
  def edit
    @entrada.date = @entrada.date.strftime("%d/%m/%Y %H:%M") # Trick to show the date in the form
  end

  # POST /entradas
  # POST /entradas.json
  def create
    @entrada = Entrada.new(entrada_params)
        
    respond_to do |format|
      if @entrada.save
        flash[:success] = I18n.t('.entradas.created')
        format.html { redirect_to @entrada }
        format.json { render :show, status: :created, location: @entrada }
      else
        format.html { render :new }
        format.json { render json: @entrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entradas/1
  # PATCH/PUT /entradas/1.json
  def update
    respond_to do |format|
      if @entrada.update(entrada_params)
        flash[:success] = I18n.t('.entradas.updated')
        format.html { redirect_to @entrada }
        format.json { render :show, status: :ok, location: @entrada }
      else
        format.html { render :edit }
        format.json { render json: @entrada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entradas/1
  # DELETE /entradas/1.json
  def destroy
    respond_to do |format|
      if @entrada.destroyed_logical
        flash[:success] = I18n.t('.entradas.destroyed')
      else 
        flash[:error] = I18n.t('.entradas.not_destroyed')
      end
      format.html { redirect_to entradas_url }
      format.json { head :no_content }
    end
  end
  
  def reporte
    template = render_to_string('reporte.xml.builder', layout: false)    
    send_doc(template, 'entrada', 'entradas.jasper', "entradas", 'pdf')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entrada
      @entrada = Entrada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entrada_params
      params.require(:entrada).permit(:client_id,:total_partidas, :date, :numero_entrada, :driver, :entregado_por, partidas_attributes: [
          :id, :identificador, :kilogramos_brutos, :numero_sacos, :numero_bolsas, :tara, :kilogramos_netos, :humedad,
          :type_coffee_id, :observaciones, :calidad_cafe, :_destroy])
    end
end
