require 'test_helper'

class GraphicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get graphics_index_url
    assert_response :success
  end

end
