require 'test_helper'

class ReadingContentsControllerTest < ActionController::TestCase
  setup do
    @reading_content = reading_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reading_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reading_content" do
    assert_difference('ReadingContent.count') do
      post :create, reading_content: {  }
    end

    assert_redirected_to reading_content_path(assigns(:reading_content))
  end

  test "should show reading_content" do
    get :show, id: @reading_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reading_content
    assert_response :success
  end

  test "should update reading_content" do
    patch :update, id: @reading_content, reading_content: {  }
    assert_redirected_to reading_content_path(assigns(:reading_content))
  end

  test "should destroy reading_content" do
    assert_difference('ReadingContent.count', -1) do
      delete :destroy, id: @reading_content
    end

    assert_redirected_to reading_contents_path
  end
end
