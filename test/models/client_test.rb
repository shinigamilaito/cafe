# == Schema Information
#
# Table name: clients
#
#  id                   :integer          not null, primary key
#  legal_representative :string
#  address              :text
#  organization         :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  persona_fisica       :boolean          default(FALSE)
#  is_historical        :boolean          default(FALSE)
#  delete_logical       :boolean          default(FALSE)
#

require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def new_client
    clients(:juan)		
  end
  
  test "client attributes must not be empty" do
    client = Client.new
    assert client.invalid?
    assert client.errors[:legal_representative].any?	
    assert client.errors[:address].any?
    assert client.errors[:organization].any?    
  end
  
  test "unique clients por representante legal" do
    client = new_client
        
    another_client = Client.new(client.attributes)
    
    assert another_client.invalid?  
    
    assert_equal ['ya existe'],
      another_client.errors[:legal_representative]
  end
  
  test "unique clients por organizacion" do
    client = new_client
    
    another_client = Client.new(client.attributes)
    
    assert another_client.invalid?  
    
    assert_equal ['ya existe'],
      another_client.errors[:organization]
  end
  
  test "obtain total entradas" do
    client = new_client
    
    assert_equal client.total_entradas, 1
    assert_equal client.entradas.size, 2    
  end
  
end
