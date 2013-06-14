require 'test_helper'

module Infodeploy
  class SectionControllerTest < ActionController::TestCase
    test "should get managerment" do
      get :managerment
      assert_response :success
    end
  
  end
end
