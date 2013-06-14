# -*- coding: utf-8 -*-
module Infodeploy
  class SearchHistoriesController < ApplicationController
    before_filter :get_history, :only => [:edit,:update,:destroy]
  	def index
  	  @histories=SearchHistory.all.desc("count")
  	  p @histories
  	end

  	def destroy
  	  @histor.destroy
  	  redirect_to :action => :index
  	end

  	def update
  	  if @history.update_attributes(params[:history])
  	  	redirect_to :action => :index
  	  else
  	  	render "edit"
  	  end
  	end

    private
    def get_history
      @history=SearchHistory.find(params[:id])
    end
  end
end
