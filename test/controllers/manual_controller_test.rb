require 'test_helper'

class ManualControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manual_index_url
    assert_response :success
  end

end
