xml.instruct!
xml.clients do
  @clients.each do |client|
    xml.client do
      xml.representante_legal client.legal_representative
      xml.direccion client.address
      xml.organizacion client.organization
    end
  end
end