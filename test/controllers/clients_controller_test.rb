require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:pedro)    
  end

  test "should get index" do
    get clients_url
    assert_response :success
    assert_select ".row .col-sm-12 h1.title-md", 1
    assert_select ".pull-right a.btn-ghost.btn-primary", 1
    assert_select "h1.text-uppercase", I18n.t('clients.index.title')
    assert_select ".table-responsive table.table", 1
    assert_select "table tbody tr", minimum: 2
  end

  test "should get new" do
    get new_client_url
    assert_response :success
    assert_select "h1.title-md", I18n.t('clients.new.title')
    assert_select "div#formulario-clientes", 1
    assert_select "input[type=radio]", 2
    assert_select "input[type=text]#client_legal_representative", 1
    assert_select "input[type=text]#client_organization", 1
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
    assert_select "h1.title-md", I18n.t('clients.show.title')
    assert_select "ul.nav.nav-tabs.nav-tabs-shop li a", 'Información Personal'
    assert_select "ul.nav.nav-tabs.nav-tabs-shop li a", /Entradas/
    assert_select "div.tab-content div.tab-pane#specifications", 1
    assert_select "div.tab-content div.tab-pane#comments", 1    
  end

  test "should get edit" do
    get edit_client_url(@client)
    assert_response :success
    assert_select "h1.title-md", I18n.t('clients.edit.title')
    assert_select "div#formulario-clientes", 1
    assert_select "input[type=radio]", 2
    assert_select "input[type=text]#client_legal_representative", 1
    assert_select "input[type=text]#client_organization", 1
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
    
    assert(Client.last.delete_logical)
    assert_redirected_to clients_url
  end
  
end
