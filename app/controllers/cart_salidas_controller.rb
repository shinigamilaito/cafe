class CartSalidasController < ApplicationController
  before_action :set_cart_salida, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart_salida

  # GET /cart_salidas
  # GET /cart_salidas.json
  def index
    @cart_salidas = CartSalida.all
  end

  # GET /cart_salidas/1
  # GET /cart_salidas/1.json
  def show
  end

  # GET /cart_salidas/new
  def new
    @cart_salida = CartSalida.new
  end

  # GET /cart_salidas/1/edit
  def edit
  end

  # POST /cart_salidas
  # POST /cart_salidas.json
  def create
    @cart_salida = CartSalida.new(cart_salida_params)

    respond_to do |format|
      if @cart_salida.save
        format.html { redirect_to @cart_salida, notice: 'Cart salida was successfully created.' }
        format.json { render :show, status: :created, location: @cart_salida }
      else
        format.html { render :new }
        format.json { render json: @cart_salida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_salidas/1
  # PATCH/PUT /cart_salidas/1.json
  def update
    respond_to do |format|
      if @cart_salida.update(cart_salida_params)
        format.html { redirect_to @cart_salida, notice: 'Cart salida was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_salida }
      else
        format.html { render :edit }
        format.json { render json: @cart_salida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_salidas/1
  # DELETE /cart_salidas/1.json
  def destroy
    if @cart_salida.id == session[:cart_salida_id]
      # Todas la salidas en un cart son del mismo cliente
      cliente = @cart_salida.line_item_salidas.first.partida.entrada.client
      @cart_salida.destroy 
    end
    session[:cart_salida_id] = nil
    respond_to do |format|
      flash[:success] = 'Salida a proceso exitosamente cancelada'
      format.html { redirect_to cliente }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_salida
      @cart_salida = CartSalida.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_salida_params
      params.fetch(:cart_salida, {})
    end
    
    def invalid_cart_salida
      logger.error "Attempt to access invalid cart salida #{params[:id]}"
      flash[:danger] = 'Salida a proceso no valido'
      redirect_to root_url
    end
end
