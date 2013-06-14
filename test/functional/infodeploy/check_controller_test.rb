require 'test_helper'

module Infodeploy
  class CheckControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
    test "should get item" do
      get :item
      assert_response :success
    end
  
  end
end
