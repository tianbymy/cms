# -*- coding: utf-8 -*-
module Infodeploy
  class AdminsController < ApplicationController

    def index
    end

    def logout
      CASClient::Frameworks::Rails::Filter.logout(self)
    end

  end
end
