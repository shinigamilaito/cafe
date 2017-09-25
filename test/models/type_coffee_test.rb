require 'test_helper'

class TypeCoffeeTest < ActiveSupport::TestCase
  def new_type_coffee
    type_coffees(:pergamino)		
  end
  
  test "type coffee attributes must not be empty" do
    type_coffee = TypeCoffee.new
    assert type_coffee.invalid?
    assert type_coffee.errors[:name].any?	    
  end
  
  test "unique type coffees" do
    type_coffee = new_type_coffee
    
    another_type_coffee = TypeCoffee.new(type_coffee.attributes)
    
    assert another_type_coffee.invalid?  
    
    assert_equal ['ya existe'],
      another_type_coffee.errors[:name]
  end
end
