# -*- coding: utf-8 -*-
module Infodeploy
  class HomeController < ApplicationController
    before_filter :get_channels,:only => [:edit,:create,:new,:update]
    before_filter :get_area,:only => [:edit,:create,:new,:update]
    before_filter :get_home_management,:only => [:edit,:destroy,:update]
    def index
      #@news = News.where(:state => "success")
    end

    def item
      @item = News.find(params[:id])
    end

    def managerment
      @areas=[1,2,3]
    end

    def edit
    end

    def update
      if @home_management.update_attributes(params[:home_management])
        redirect_to :action => :managerment
      else
        render "edit"
      end
    end

    def new
      @home_management=HomeManagerment.new
    end

    def create
      @home_management=HomeManagerment.new(params[:home_management])
      @home_management.number = @area
      if @home_management.save
        redirect_to :action => :managerment
      else
        render "new"
      end
    end

    def destroy
      @home_management.destroy
      redirect_to :action => :managerment
    end

    private
    def get_channels
      @channels=Channel.where(:enabled => 0).asc("number")
    end

    def get_area
      @area=params[:area]
    end

    def get_home_management
      @home_management=HomeManagerment.find(params[:id])
    end
  end
end
