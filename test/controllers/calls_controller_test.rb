require 'test_helper'

class CallsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get calls_show_url
    assert_response :success
  end

end
