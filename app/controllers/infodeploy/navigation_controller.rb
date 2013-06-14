module Infodeploy
  class NavigationController < ApplicationController
    before_filter :get_navigation, :only => [:edit,:update,:destroy]
    def managerment
      @navigation = NavigationManagerment.asc("number").all
      @page = Infodeploy::Page.first
    end

    def new
      @navigation = NavigationManagerment.new
    end

    def create
      @navigation = NavigationManagerment.new(params[:navigation])
      @navigation[:system]=1
      if @navigation.save
        redirect_to :action => :managerment
      else
        render "new"
      end
    end

    def update
      if @navigation.update_attributes(params[:navigation])
        redirect_to :action => :managerment
      else
        render "edit"
      end
    end
    
    def destroy
      @navigation.destroy
      redirect_to :action => :managerment
    end

    private
    def get_navigation
      @navigation = NavigationManagerment.find(params[:id])
    end
  end
end
