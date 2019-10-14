require 'test_helper'

class AdicionadosControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get adicionados_create_url
    assert_response :success
  end

end
