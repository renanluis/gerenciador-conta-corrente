require "test_helper"

class WithdrawControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get withdraw_index_url
    assert_response :success
  end
end
