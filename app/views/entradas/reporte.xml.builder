xml.instruct!
xml.entrada do
  xml.fecha l(@entrada.date, format: :medium_date)
  xml.numero_entrada padded_zeros_numero_entrada(@entrada.numero_entrada)
#  xml.chofer @entrada.driver
  xml.entregado_por @entrada.entregado_por
#  xml.total_partidas @entrada.total_partidas
  xml.total_kilos_brutos number_with_precision(@entrada.total_kilos_brutos, precision: 2)
  xml.total_tara number_with_precision(@entrada.total_tara, precision: 2)
  xml.total_kilos_netos number_with_precision(@entrada.total_kilos_netos, precision: 2)
  xml.cliente do
    xml.representante_legal @entrada.client.legal_representative
    xml.direccion @entrada.client.address
    xml.organizacion @entrada.client.organization
  end  
  xml.partidas do
    @entrada.partidas.order("identificador ASC").each do |partida|
      xml.partida do
#        xml.identificador partida.identificador
        xml.kilogramos_brutos number_with_precision(partida.kilogramos_brutos, precision: 2)
        xml.tara number_with_precision(partida.tara, precision: 2)
        xml.kilogramos_netos number_with_precision(partida.kilogramos_netos, precision: 2)
        xml.numero_sacos partida.numero_sacos
        xml.numero_bolsas partida.numero_bolsas
        xml.humedad number_with_precision(partida.humedad, precision: 2)
        xml.tipo_cafe partida.type_coffee.name
        xml.calidad_cafe partida.calidad_cafe
        xml.observaciones partida.observaciones
      end
    end    
  end
end