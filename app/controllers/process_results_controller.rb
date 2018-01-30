class ProcessResultsController < ApplicationController
  before_action :set_process_result, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_process_result

  # GET /process_results
  # GET /process_results.json
  def index    
    @process_results = ProcessResult.order(:created_at).page(params[:page])  
  end

  # GET /process_results/1
  # GET /process_results/1.json
  def show
  end

  # GET /process_results/new?id_salida_proceso=1
  def new
    @salida_proceso = SalidaProceso.find(params[:id_salida_proceso])
    
    if @salida_proceso.process_result      
      flash[:danger] = 'Ya existe un resultado registrado para esta salida.'
      redirect_to @salida_proceso      
    else
      @process_result = ProcessResult.new
    
      # Colocar la lista de calidades
      QualityType.all.each do |quality_type| 
        quality = Quality.new(kilos_totales: '0', percentage: '0', sacos: 0, kilos_sacos: 0)
        quality.quality_type = quality_type
        @process_result.qualities << quality
      end 
    
      @process_result.salida_proceso = @salida_proceso
    end
    
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /process_results
  # POST /process_results.json
  def create
    @process_result = ProcessResult.new(process_result_params)

    respond_to do |format|
      if @process_result.save
        flash[:success] = I18n.t('.process_result.created')
        format.html { redirect_to @process_result }
        format.json { render :show, status: :created, location: @process_result }
      else
        format.html { render :new }
        format.json { render json: @process_result.errors, status: :unprocessable_entity }
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
    def set_process_result
      @process_result = ProcessResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def process_result_params
      params.require(:process_result).permit(:salida_proceso_id, :date, :rango_lote, 
          :fecha_inicio, :fecha_termino, :humedad, :hora_inicio, :hora_termino, 
          :total_kilos_totales, :total_porcentaje, :total_sacos, :total_kilos_sacos,
          :rendimiento, :observaciones, 
          qualities_attributes: [
          :id, :quality_type_id, :kilos_totales, :percentage, :sacos, :kilos_sacos, 
          :_destroy])
    end
    
    def invalid_process_result
      logger.error "Attempt to access invalid result process #{params[:id]}"
      flash[:danger] = 'Resultado a proceso no valido'
      redirect_to root_url
    end
    
end
