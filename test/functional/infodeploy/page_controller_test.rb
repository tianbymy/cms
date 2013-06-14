require 'test_helper'

module Infodeploy
  class PageControllerTest < ActionController::TestCase
    test "should get managerment" do
      get :managerment
      assert_response :success
    end
  
  end
end
