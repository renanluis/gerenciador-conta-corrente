require "test_helper"

class StatementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get statement_index_url
    assert_response :success
  end
end
