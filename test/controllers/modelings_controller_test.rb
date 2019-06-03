require 'test_helper'

class ModelingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get modelings_create_url
    assert_response :success
  end

end
