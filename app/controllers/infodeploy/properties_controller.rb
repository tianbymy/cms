# -*- coding: utf-8 -*-
module Infodeploy
  class PropertiesController < ApplicationController
    before_filter :get_property,:only => [:edit,:update,:destroy]
  	def index
  	  @properties = Property.all
  	end

  	def new
  	  @property = Property.new
  	end

  	def create
  	  @property = Property.new(params[:property])
      @property[:system]=1
  	  if @property.save
  	  	redirect_to :action => :index
  	  else
  	  	render "new"
  	  end
  	end

    def edit
    end

    def update
      if @property.update_attributes(params[:property])
        redirect_to :action => :index
      else
        render "edit"
      end
    end

    def destroy
      @property.destroy
      redirect_to :action => :index
    end

    private
    def get_property
      @property = Property.find(params[:id])
    end
  end
end
