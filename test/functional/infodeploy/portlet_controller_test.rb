require 'test_helper'

module Infodeploy
  class PortletControllerTest < ActionController::TestCase
    test "should get managerment" do
      get :managerment
      assert_response :success
    end
  
  end
end
