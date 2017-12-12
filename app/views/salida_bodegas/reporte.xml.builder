xml.instruct!
xml.salida do
  xml.fecha l(@salida_bodega.created_at, format: :medium_date)
  xml.numero_salida padded_zeros_numero_entrada(@salida_bodega.numero_salida)
  xml.numero_salida_cliente padded_zeros_numero_entrada(@salida_bodega.numero_salida_cliente)  
  xml.entregado_por @salida_bodega.entradas_afectadas.map(&:entregado_por).join("-")
  xml.total_kilos_brutos number_with_precision(@salida_bodega.line_item_salida_bodegas.map() {|item| BigDecimal(item.partida.kilogramos_brutos)}.reduce(BigDecimal("0"), :+), precision: 2)
  xml.total_tara number_with_precision(@salida_bodega.line_item_salida_bodegas.map() {|item| BigDecimal(item.partida.tara)}.reduce(BigDecimal("0"), :+), precision: 2)
  xml.total_kilos_netos number_with_precision(@salida_bodega.line_item_salida_bodegas.map() {|item| BigDecimal(item.total_kilogramos_netos)}.reduce(BigDecimal("0"), :+), precision: 2)
  xml.imagen asset_url('logo/logo_cafe.jpg')
  xml.nombre_chofer @salida_bodega.name_driver
  xml.persona_lleva_cafe @salida_bodega.name_person
  xml.observaciones @salida_bodega.observaciones  
  xml.cliente do
    xml.representante_legal @salida_bodega.entradas_afectadas.map() {|e| e.client.legal_representative}.join("-")    
    xml.organizacion @salida_bodega.entradas_afectadas.map() {|e| e.client.organization}.join("-")
  end
  xml.item_salidas do
    @salida_bodega.line_item_salida_bodegas.order("created_at ASC").each do |item_salida|
      xml.item do
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
