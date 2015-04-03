require 'test_helper'

class FollowersControllerTest < ActionController::TestCase
  setup do
    @follower = followers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:followers)
  end

  test "should create follower" do
    assert_difference('Follower.count') do
      post :create, follower: { category_id: @follower.category_id, twitterHandle: @follower.twitterHandle }
    end

    assert_response 201
  end

  test "should show follower" do
    get :show, id: @follower
    assert_response :success
  end

  test "should update follower" do
    put :update, id: @follower, follower: { category_id: @follower.category_id, twitterHandle: @follower.twitterHandle }
    assert_response 204
  end

  test "should destroy follower" do
    assert_difference('Follower.count', -1) do
      delete :destroy, id: @follower
    end

    assert_response 204
  end
end
