require 'test_helper'

class ExportControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get pdf" do
    get :pdf
    assert_response :success
  end

  test "should get word" do
    get :word
    assert_response :success
  end

  test "should get excel" do
    get :excel
    assert_response :success
  end

  test "should get powerpoint" do
    get :powerpoint
    assert_response :success
  end

end
