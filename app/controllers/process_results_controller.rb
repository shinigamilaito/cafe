class ProcessResultsController < ApplicationController
  before_action :set_process_result, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_process_result

  # GET /process_results
  # GET /process_results.json
  def index    
    @clients = Client.validos.order(:legal_representative).page(params[:page])    
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @cart_salida_proceso.destroy  if @cart_salida_proceso.id == session[:cart_salida_proceso_id] # Las salidas deben ser por cliente
    @cart_salida_bodega.destroy  if @cart_salida_bodega.id == session[:cart_salida_bodega_id]
    session[:cart_salida_proceso_id] = nil
    session[:cart_salida_bodega_id] = nil
    @line_item_salida_proceso = LineItemSalidaProceso.new
    @line_item_salida_bodega = LineItemSalidaBodega.new    
    @merma = Merma.new
  end

  # GET /process_results/new?id_salida_proceso=1
  def new
    @salida_proceso = SalidaProceso.find(params[:id_salida_proceso])
    @process_result = ProcessResult.new
    
    # Colocar la lista de calidades
    QualityType.all.each do |quality_type| 
      quality = Quality.new(kilos_totales: '0', percentage: '0', sacos: 0, kilos_sacos: 0)
      quality.quality_type = quality_type
      @process_result.qualities << quality
    end 
    
    @process_result.salida_proceso = @salida_proceso
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        flash[:success] = I18n.t('.clients.created')
        format.html { redirect_to @client }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|      
      if(@client = @client.check_it_is_using_for_another_models(client_params))
        flash[:success] = I18n.t('.clients.updated')
        format.html { redirect_to @client }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroyed_logical
    flash[:success] = I18n.t('.clients.destroyed')
    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:legal_representative, :address, :organization, :persona_fisica)
    end
    
    def invalid_process_result
      logger.error "Attempt to access invalid result process #{params[:id]}"
      flash[:danger] = 'Resultado a proceso no valido'
      redirect_to root_url
    end
    
end
