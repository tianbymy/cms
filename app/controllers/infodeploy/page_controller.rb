module Infodeploy
  class PageController < ApplicationController
    before_filter :get_page, :only => [:edit,:update,:destroy]
    def managerment
      @page=Page.all      
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(params[:page])
      @page[:system]=1
      if @page.save
        redirect_to :action => :managerment
      else
        render "new"
      end
    end

    def update
      if @page.update_attributes(params[:page])
        redirect_to :action => :managerment
      else
        render "edit"
      end
    end


    def destroy
      @page.destroy
      redirect_to :action => :managerment
    end

    private
    def get_page
      @page = Page.find(params[:id])
    end
  end
end
