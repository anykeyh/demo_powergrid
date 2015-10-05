require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  test "should get inedx" do
    get :inedx
    assert_response :success
  end

end
