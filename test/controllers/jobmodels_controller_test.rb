require 'test_helper'

class JobmodelsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get jobmodels_create_url
    assert_response :success
  end

  test "should get destroy" do
    get jobmodels_destroy_url
    assert_response :success
  end

end
