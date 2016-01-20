require 'test_helper'

class SourceDataControllerTest < ActionController::TestCase
  test "should get chart" do
    get :chart
    assert_response :success
  end

  test "should get nsnlist" do
    get :nsnlist
    assert_response :success
  end

  test "should get source" do
    get :source
    assert_response :success
  end

  test "should get sourceref" do
    get :sourceref
    assert_response :success
  end

  test "should get sourceinv" do
    get :sourceinv
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get dictionary_detail" do
    get :dictionary_detail
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

  test "should get viewsource" do
    get :viewsource
    assert_response :success
  end

  test "should get cage_details" do
    get :cage_details
    assert_response :success
  end

end
