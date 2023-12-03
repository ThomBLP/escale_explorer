require "test_helper"

class CheckcardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get checkcard_index_url
    assert_response :success
  end
end
