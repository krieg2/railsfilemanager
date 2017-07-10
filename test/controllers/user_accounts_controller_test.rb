require 'test_helper'

class UserAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_accounts_index_url
    assert_response :success
  end

  test "should get new" do
    get user_accounts_new_url
    assert_response :success
  end

end
