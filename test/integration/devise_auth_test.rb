require "test_helper"

class DeviseAuthTest < ActionDispatch::IntegrationTest
  test "user can login" do
    user = users(:one)
    sign_in user
    get root_path
    assert_response :success
  end
end
