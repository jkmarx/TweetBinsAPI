require 'test_helper'

class UserAuthenticationsControllerTest < ActionController::TestCase
  setup do
    @user_authentication = user_authentications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_authentications)
  end

  test "should create user_authentication" do
    assert_difference('UserAuthentication.count') do
      post :create, user_authentication: { token: @user_authentication.token, token_expires_at: @user_authentication.token_expires_at, user_id: @user_authentication.user_id }
    end

    assert_response 201
  end

  test "should show user_authentication" do
    get :show, id: @user_authentication
    assert_response :success
  end

  test "should update user_authentication" do
    put :update, id: @user_authentication, user_authentication: { token: @user_authentication.token, token_expires_at: @user_authentication.token_expires_at, user_id: @user_authentication.user_id }
    assert_response 204
  end

  test "should destroy user_authentication" do
    assert_difference('UserAuthentication.count', -1) do
      delete :destroy, id: @user_authentication
    end

    assert_response 204
  end
end
