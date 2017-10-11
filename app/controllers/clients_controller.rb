class ClientsController < ApplicationController
  include CurrentCartSalidas
  before_action :set_cart_salidas
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.validos.order("updated_at DESC")    
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @cart_salida.destroy  if @cart_salida.id == session[:cart_salida_id]
    session[:cart_salida_id] = nil
  end

  # GET /clients/new
  def new
    @client = Client.new
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
    
end
