require 'test_helper'

class ReferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get references_create_url
    assert_response :success
  end

  test "should get destroy" do
    get references_destroy_url
    assert_response :success
  end

end
