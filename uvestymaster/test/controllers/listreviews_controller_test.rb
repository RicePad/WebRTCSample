require 'test_helper'

class ListreviewsControllerTest < ActionController::TestCase
  setup do
    @listreview = listreviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listreviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listreview" do
    assert_difference('Listreview.count') do
      post :create, listreview: { comment: @listreview.comment, rating: @listreview.rating }
    end

    assert_redirected_to listreview_path(assigns(:listreview))
  end

  test "should show listreview" do
    get :show, id: @listreview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listreview
    assert_response :success
  end

  test "should update listreview" do
    patch :update, id: @listreview, listreview: { comment: @listreview.comment, rating: @listreview.rating }
    assert_redirected_to listreview_path(assigns(:listreview))
  end

  test "should destroy listreview" do
    assert_difference('Listreview.count', -1) do
      delete :destroy, id: @listreview
    end

    assert_redirected_to listreviews_path
  end
end
