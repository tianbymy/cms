module Infodeploy
  class LayoutController < ApplicationController
    before_filter :get_layout, :only => [:edit,:update,:destroy]
    def managerment
      @layout = Layout.all.asc("file")
    end

    def new
      @layout = Layout.new
    end

    def create
      @layout = Layout.new(params[:layout])
      @layout[:system]=1
      if @layout.save
        redirect_to :action => :managerment
      else
        render "new"
      end
    end

    def update
      if @layout.update_attributes(params[:layout])
        redirect_to :action => :managerment
      else
        render "edit"
      end
    end


    def destroy
      @layout.destroy
      redirect_to :action => :managerment
    end

    private
    def get_layout
      @layout = Layout.find(params[:id])
    end
  end
end
