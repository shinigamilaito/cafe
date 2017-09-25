module EntradasHelper
  include ActionView::Helpers::NumberHelper
  
  def href_partida(counter)
    "#partida-#{counter + 1}"
  end
  
  def partida_title(counter)
    "Partida: #{counter + 1}"
  end
  
  def id_partida(counter)
    "partida-#{counter + 1}"
  end
  
  def padded_zeros_numero_entrada(numero_entrada)
    sprintf("%05i", numero_entrada)
  end  

end
