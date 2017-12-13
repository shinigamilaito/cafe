xml.instruct!
xml.salida do
  xml.fecha l(@salida_proceso.created_at, format: :medium_date)
  xml.numero_salida padded_zeros_numero_entrada(@salida_proceso.numero_salida)
  xml.numero_salida_cliente padded_zeros_numero_entrada(@salida_proceso.numero_salida_cliente)  
  xml.entregado_por @salida_proceso.entradas_afectadas.map(&:entregado_por).uniq.join("-")
  xml.total_kilos_brutos number_with_precision(@salida_proceso.line_item_salida_procesos.map() {|item| BigDecimal(item.partida.kilogramos_brutos)}.reduce(BigDecimal("0"), :+), precision: 2)
  xml.total_tara number_with_precision(@salida_proceso.line_item_salida_procesos.map() {|item| BigDecimal(item.partida.tara)}.reduce(BigDecimal("0"), :+), precision: 2)
  xml.total_kilos_netos number_with_precision(@salida_proceso.line_item_salida_procesos.map() {|item| BigDecimal(item.total_kilogramos_netos)}.reduce(BigDecimal("0"), :+), precision: 2)
  xml.imagen asset_url('logo/logo_cafe.jpg')
  xml.cliente do
    xml.representante_legal @salida_proceso.client.legal_representative    
    xml.organizacion @salida_proceso.client.organization
  end
  xml.item_salidas do
    @salida_proceso.line_item_salida_procesos.order("created_at ASC").each do |item_salida|
      xml.item do
        xml.numero_entrada padded_zeros_numero_entrada(item_salida.partida.entrada.numero_entrada)
        xml.numero_partida padded_zeros_numero_entrada(item_salida.partida.identificador)
        xml.kilogramos_brutos number_with_precision(item_salida.partida.kilogramos_brutos, precision: 2)
        xml.tara number_with_precision(item_salida.partida.tara, precision: 2)
        xml.kilogramos_netos number_with_precision(item_salida.total_kilogramos_netos, precision: 2)
        xml.numero_sacos item_salida.total_sacos
        xml.numero_bolsas item_salida.total_bolsas
        xml.humedad number_with_precision(item_salida.partida.humedad, precision: 2)
        xml.tipo_cafe item_salida.partida.type_coffee.name
        xml.calidad_cafe item_salida.partida.calidad_cafe
        xml.observaciones item_salida.partida.observaciones
      end
    end    
  end
end
