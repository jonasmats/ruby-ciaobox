require 'test_helper'

class SetLanguageControllerTest < ActionController::TestCase
  test "should get en" do
    get :en
    assert_response :success
  end

  test "should get it" do
    get :it
    assert_response :success
  end

  test "should get fr" do
    get :fr
    assert_response :success
  end

  test "should get de" do
    get :de
    assert_response :success
  end

end
