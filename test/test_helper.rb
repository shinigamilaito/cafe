ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  class ActionDispatch::IntegrationTest
    def login_as(user)
      post user_session_path \
        "user[username]"    => user.username,
        "user[password]" => 'admin'
    end
  
    def logout
      delete logout_url
    end

    def setup
      login_as users(:administrador)
    end
    
  end  
end


