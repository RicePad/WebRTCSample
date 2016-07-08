require 'test_helper'

class MentoringsControllerTest < ActionController::TestCase
  setup do
    @mentoring = mentorings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mentorings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mentoring" do
    assert_difference('Mentoring.count') do
      post :create, mentoring: { description: @mentoring.description, name: @mentoring.name, price: @mentoring.price }
    end

    assert_redirected_to mentoring_path(assigns(:mentoring))
  end

  test "should show mentoring" do
    get :show, id: @mentoring
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mentoring
    assert_response :success
  end

  test "should update mentoring" do
    patch :update, id: @mentoring, mentoring: { description: @mentoring.description, name: @mentoring.name, price: @mentoring.price }
    assert_redirected_to mentoring_path(assigns(:mentoring))
  end

  test "should destroy mentoring" do
    assert_difference('Mentoring.count', -1) do
      delete :destroy, id: @mentoring
    end

    assert_redirected_to mentorings_path
  end
end
