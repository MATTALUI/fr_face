require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_friendship" do
    get requests_create_friendship_url
    assert_response :success
  end

end
