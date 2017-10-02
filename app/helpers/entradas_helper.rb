module EntradasHelper
  include ActionView::Helpers::NumberHelper
  
  def padded_zeros_numero_entrada(numero_entrada)
    sprintf("%05i", numero_entrada)
  end  

end
