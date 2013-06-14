module Infodeploy
  class WidgetsController < ApplicationController
    def index
      @portlets = Widgets.get_widgets
    end
  end
end