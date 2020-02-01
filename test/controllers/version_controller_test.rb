require 'test_helper'

class VersionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get version_create_url
    assert_response :success
  end

end
