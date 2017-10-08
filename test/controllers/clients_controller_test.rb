require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:pedro)    
  end

  test "should get index" do
    get clients_url
    assert_response :success
  end

  test "should get new" do
    get new_client_url
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post clients_url, params: { client: { 
          address: @client.address, 
          legal_representative: 'AAAAA', 
          organization: 'AAAAA' } 
        }
    end

    assert_redirected_to client_url(Client.last)
  end

  test "should show client" do
    get client_url(@client)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_url(@client)
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: { client: { 
        address: @client.address, 
        legal_representative: @client.legal_representative, 
        organization: @client.organization } 
      }
      
    assert_redirected_to client_url(Client.last)
  end

  test "should destroy client" do
    @client = Client.new({
        legal_representative: 'AAAA',
        address: 'DDDD',
        organization: 'EEEE'
      })
    
    @client.save
    
    assert_difference('Client.count', 0) do
      delete client_url(@client)
    end

    assert_redirected_to clients_url
  end
  
end
