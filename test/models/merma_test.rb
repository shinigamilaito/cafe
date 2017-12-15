# == Schema Information
#
# Table name: mermas
#
#  id           :integer          not null, primary key
#  merma_type   :integer          default("dry_coffee")
#  date_dry     :date
#  quantity     :string
#  observations :text
#  partida_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class MermaTest < ActiveSupport::TestCase
  def new_merma
		Merma.new(
			partida: partidas(:one),
   		date_dry: Time.now,
      quantity: "10"
		)
  end
  
  
  test "merma attributes must not be empty" do
    merma = Merma.new
    assert merma.invalid?
    assert merma.errors[:date_dry].any?	
    assert merma.errors[:quantity].any?
    assert merma.errors[:partida].any?
  end
  
  test "cantidad kilogramos netos" do
	 ok = [9, 9.87, 987.56, 674569.03,  786.54, 0.01] 
	 bad = [0.001, 0, -5679834520, "4567abc7895"]
	
	 ok.each do |kilos_mermados|
	 	merma = new_merma
    merma.quantity = kilos_mermados
    assert merma.valid?, "#{kilos_mermados} shouldn't be invalid"
	 end
	
	 bad.each do |kilos_mermados|
     merma = new_merma
     merma.quantity = kilos_mermados
	 	 assert merma.invalid?, "#{kilos_mermados} shouldn't be valid"
   end
  end
  
  test "accept only type mermas valid" do
    ok = [0, 1, 2, :dry_coffee, :sample_coffee, :time] 
    bad = [0.001, -5679834520, "4567abc7895", "tiempo", "secado"]
	
	 ok.each do |type|
	 	merma = new_merma
    merma.merma_type = type
    assert merma.valid?, "#{type} shouldn't be invalid"
	 end
	
	 bad.each do |type|
     merma = new_merma
     assert_raises("ArgumentError") { merma.merma_type = type }
   end
  end
end
