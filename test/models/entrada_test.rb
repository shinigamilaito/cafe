require 'test_helper'

class EntradaTest < ActiveSupport::TestCase
  def new_entrada
		Entrada.new(
			date: '24/09/2017 12:05',
			numero_entrada: '1',
   		driver: 'MyString',
   		entregado_por: 'MyString',   		
		)
  end

  test "entrada attributes must not be empty" do
    entrada = Entrada.new
    assert entrada.invalid?
    assert entrada.errors[:date].any?	
    assert entrada.errors[:numero_entrada].any?
    assert entrada.errors[:driver].any?
    assert entrada.errors[:entregado_por].any?    
  end
  
  test "numero entrada" do
    entrada = new_entrada
  
    last_entrada = Entrada.last.numero_entrada
   
    entrada.save
    
    assert entrada.numero_entrada, last_entrada + 1
       
  end
  
  test "unique entradas" do
    entrada = entradas(:one)
    
    another_entrada = new_entrada
    another_entrada.date = entrada.date
    another_entrada.numero_entrada = entrada.numero_entrada
    assert another_entrada.invalid?  
    
    assert_equal ['ya existe'],
      another_entrada.errors[:date]
  end
end
