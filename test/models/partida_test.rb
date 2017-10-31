# == Schema Information
#
# Table name: partidas
#
#  id                :integer          not null, primary key
#  identificador     :integer          default(1)
#  entrada_id        :integer
#  kilogramos_brutos :string
#  numero_sacos      :integer
#  tara              :string
#  kilogramos_netos  :string
#  humedad           :string
#  type_coffee_id    :integer
#  calidad_cafe      :string
#  observaciones     :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  numero_bolsas     :integer
#

require 'test_helper'

class PartidaTest < ActiveSupport::TestCase
  def new_partida
		Partida.new(
			entrada: entradas(:one),
			kilogramos_brutos: 150.00,
      numero_bolsas: 50,
      numero_sacos: 5,
   		tara: 50 + 5*0.100,
   		kilogramos_netos: 90.00,
   		humedad: 15,
   		type_coffee: type_coffees(:pergamino),
   		calidad_cafe: 'Oro'   		
		)
  end

  test "kilogramos brutos" do
	 ok = [9, 9.875, 987.56, 674569.03,  786.54, 0.01] 
	 bad = [0.001, 0, -5679834520, "4567abc7895"]
	
	 ok.each do |kilogramos_brutos|
	 	partida = new_partida
    partida.kilogramos_brutos = kilogramos_brutos
    assert partida.valid?, "#{kilogramos_brutos} shouldn't be invalid"
	 end
	
	 bad.each do |kilogramos_brutos|
     partida = new_partida
     partida.kilogramos_brutos = kilogramos_brutos
	 	 assert partida.invalid?, "#{kilogramos_brutos} shouldn't be valid"
   end
  end
  
  test "tara" do
	 ok = [9, 9.875, 987.56, 674569.03,  786.54, 0.01] 
	 bad = [0.001, 0, -5679834520, "4567abc7895"]
	
	 ok.each do |tara|
	 	partida = new_partida
    partida.tara = tara
    assert partida.valid?, "#{tara} shouldn't be invalid"
	 end
	
	 bad.each do |tara|
     partida = new_partida
     partida.tara = tara
	 	 assert partida.invalid?, "#{tara} shouldn't be valid"
   end
  end
  
  test "kilogramos netos" do
	 ok = [9, 9.875, 987.56, 674569.03,  786.54, 0.01] 
	 bad = [0.001, 0, -5679834520, "4567abc7895"]
	
	 ok.each do |kilogramos_netos|
	 	partida = new_partida
    partida.kilogramos_netos = kilogramos_netos
    assert partida.valid?, "#{kilogramos_netos} shouldn't be invalid"
	 end
	
	 bad.each do |kilogramos_netos|
     partida = new_partida
     partida.kilogramos_netos = kilogramos_netos
	 	 assert partida.invalid?, "#{kilogramos_netos} shouldn't be valid"
   end
  end
  
  test "humedad" do
	 ok = [19, 19.875, 17.56, 19.03,  14, 10.01] 
	 bad = [0.001, 0, -5679834520, "4567abc7895", 9.99, 21, 20.01]
	
	 ok.each do |humedad|
	 	partida = new_partida
    partida.humedad = humedad
    assert partida.valid?, "#{humedad} shouldn't be invalid"
	 end
	
	 bad.each do |humedad|
     partida = new_partida
     partida.humedad = humedad
	 	 assert partida.invalid?, "#{humedad} shouldn't be valid"
   end
  end
  
  test "numero bolsas" do
	 ok = [19, 875, 156, 3,  14, 10, 21, 0] 
	 bad = [0.001, -5679834520, "4567abc7895", 9.99, 20.01]
	
	 ok.each do |numero_bolsas|
	 	partida = new_partida
    partida.numero_bolsas = numero_bolsas    
    assert partida.save, "#{numero_bolsas} shouldn't be invalid"
	 end
	
	 bad.each do |numero_bolsas|
     partida = new_partida
     partida.numero_bolsas = numero_bolsas     
	 	 assert_not partida.save, "#{numero_bolsas} shouldn't be valid"
   end
  end
  
  test "numero sacos" do
	 ok = [19, 875, 156, 3,  14, 10, 21.0, 0] 
	 bad = [0.001, -5679834520, "4567abc7895", 9.99, 21.01, 20.01]
	
	 ok.each do |numero_sacos|
	 	partida = new_partida
    partida.numero_sacos = numero_sacos
    assert partida.save, "#{numero_sacos} shouldn't be invalid"
	 end
	
	 bad.each do |numero_sacos|
     partida = new_partida
     partida.numero_sacos = numero_sacos
	 	 assert_not partida.save, "#{numero_sacos} shouldn't be valid"
   end
  end

  test "partida attributes must not be empty" do
    partida = Partida.new
    assert partida.invalid?
    assert partida.errors[:kilogramos_brutos].any?	
    assert partida.errors[:numero_sacos].any?
    assert partida.errors[:numero_bolsas].any?
    assert partida.errors[:tara].any?
    assert partida.errors[:kilogramos_netos].any?
    assert partida.errors[:humedad].any?
    assert partida.errors[:type_coffee_id].any?
    assert partida.errors[:calidad_cafe].any?    
  end
  
  test "valor tara es correcto" do
    partida = new_partida
    partida.numero_sacos = 50
    partida.numero_bolsas = 3
    partida.tara = "50.3"
    partida.save
    
    assert_equal partida.tara, "50.3"
  end
  
  test "valor tara no es correcto" do
    partida = new_partida
    partida.numero_sacos = 50
    partida.numero_bolsas = 3
    partida.tara = "50.1"
    
    partida.save
    
    assert_equal ['El valor no corresponde a la diferencia entre sacos y bolsas'],
      partida.errors[:tara]
  end
  
  test "valor kilogramos netos es correcto" do
    partida = new_partida
    partida.kilogramos_brutos = 50
    partida.tara = 3
    partida.kilogramos_netos = 47
    partida.save
    
    assert_equal partida.kilogramos_netos, '47'
  end
  
  test "valor kilogramos netos no es correcto" do
    partida = new_partida
    partida.kilogramos_brutos = 50
    partida.tara = 3
    partida.kilogramos_netos = 67
    
    partida.save
    
    assert_equal ['El valor no corresponde a la diferencia entre kilogramos brutos y tara'],
      partida.errors[:kilogramos_netos]
  end
  
  test "should order by identificador ascendente" do
    partidas = entradas(:one).partidas.identificador_ascendente
    
    assert_equal partidas[0].identificador, 1 
    assert_equal partidas[1].identificador, 2
  end

end
