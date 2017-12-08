# == Schema Information
#
# Table name: entradas
#
#  id                     :integer          not null, primary key
#  date                   :datetime
#  numero_entrada         :integer
#  driver                 :string
#  entregado_por          :string
#  total_partidas         :integer          default(1)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  delete_logical         :boolean          default(FALSE)
#  client_id              :integer
#  numero_entrada_cliente :integer          default(0)
#

require 'test_helper'

class EntradaTest < ActiveSupport::TestCase
  def new_entrada
		Entrada.new(
			date: '24/09/2017 12:05',
			numero_entrada: '1',
			numero_entrada_cliente: '2',
   		driver: 'MyString',
   		entregado_por: 'MyString',  
      client: clients(:pedro)   		      
		)
  end

  test "entrada attributes must not be empty" do
    entrada = Entrada.new
    assert entrada.invalid?
    assert entrada.errors[:date].any?	
    assert entrada.errors[:numero_entrada].any?
    assert entrada.errors[:driver].any?
    assert entrada.errors[:entregado_por].any? 
    assert entrada.errors[:client_id].any?    
  end
  
  test "numero entrada" do
    entrada = new_entrada
  
    last_entrada = Entrada.last.numero_entrada
   
    entrada.save
    
    assert entrada.numero_entrada, last_entrada + 1
       
  end
  
  test "numero entrada por cliente" do
    entrada = new_entrada
  
    last_entrada_cliente = Entrada.last.numero_entrada_cliente
   
    entrada.save
    
    assert entrada.numero_entrada_cliente, last_entrada_cliente + 1
       
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
  
  test "destroyed logical" do
    entrada = entradas(:one)
    
    assert_difference('Entrada.count', 0) do      
      assert_not entrada.delete_logical
      entrada.destroyed_logical
      assert entrada.delete_logical
    end
  end
  
  test "obtain only validas" do
    entradas_scope = Entrada.validas
    entradas_consult = Entrada.where(delete_logical: false)
    
    assert_equal(entradas_scope, entradas_consult, "Las entradas no coinciden")
  end
  
  test "total kilogramos brutos, tara, kilogramos netos" do
    entrada = entradas(:one)
    assert_equal entrada.total_kilos_brutos, "156.99"
    assert_equal entrada.total_tara, "31.3" 
    assert_equal entrada.total_kilos_netos, "125.7" 
  end
  
  test "total partidas" do
    entrada = entradas(:one)
    
    assert entrada.save
    assert_equal entrada.total_partidas, 1
  end
  
  test "should order by numero entrada ascendente" do
    entradas = Entrada.numero_entrada_ascendente
    
    assert_equal entradas[0].numero_entrada, 1 
    assert_equal entradas[1].numero_entrada, 2
    assert_equal entradas[2].numero_entrada, 3  
  end
  
  test "obtain total partidas" do
    entrada = entradas(:one)
    
    assert_equal entrada.total_partidas, 1
  end
  
  test "tiene partidas que han salido a proceso" do
    entrada = entradas(:one)
    
    assert(entrada.tiene_partidas_con_salidas)
  end
  
  test "no tiene partidas que han salido a proceso" do
    entrada = entradas(:sin_salida_proceso)
    
    assert_not(entrada.tiene_partidas_con_salidas)
  end
  
end
