require 'test_helper'

class UploadedFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uploaded_files_index_url
    assert_response :success
  end

  test "should get new" do
    get uploaded_files_new_url
    assert_response :success
  end

  test "should get show" do
    get uploaded_files_show_url
    assert_response :success
  end

end
