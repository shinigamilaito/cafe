require 'test_helper'

class PartidaTest < ActiveSupport::TestCase
  def new_partida
		Partida.new(
			entrada: entradas(:one),
			kilogramos_brutos: 150.00,
      numero_bultos: 50,
   		tara: 60.00,
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

  test "partida attributes must not be empty" do
    partida = Partida.new
    assert partida.invalid?
    assert partida.errors[:kilogramos_brutos].any?	
    assert partida.errors[:numero_bultos].any?
    assert partida.errors[:tara].any?
    assert partida.errors[:kilogramos_netos].any?
    assert partida.errors[:humedad].any?
    assert partida.errors[:type_coffee_id].any?
    assert partida.errors[:calidad_cafe].any?    
  end

end
