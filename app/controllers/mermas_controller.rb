class MermasController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_salida_merma

  # POST /salida_bodegas
  # POST /salida_bodegas.json
  def create
    @merma = Merma.new(merma_params)

    respond_to do |format|
      if @merma.save
        flash[:success] = I18n.t('mermas.created')        
        format.html { redirect_to @merma.partida }
        format.js
        format.json { render :show, status: :created, location: @merma }
      else
        flash[:error] = I18n.t('mermas.not_created')        
        format.html { redirect_to @merma.partida }
        format.js {render :not_create}
        format.json { render json: @merma.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    
    def merma_params
      params.require(:merma).permit(:date_dry, :quantity, :observations, :partida_id)
    end
end
