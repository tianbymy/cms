# -*- coding: utf-8 -*-
module Infodeploy
  class KindsController < ApplicationController
    before_filter :get_kind, :only => [:edit,:update,:destroy]
  	def new
      @kind=Kind.new
  	end

  	def create
      @kind=Kind.new(params[:kind])
      if @kind.save
      	redirect_to :controller => :partners,:action => :index
      else
      	render "new"
      end
  	end

  	def update
      if @kind.update_attributes(params[:kind])
      	redirect_to :controller => :partners,:action => :index
      else
      	render "edit"
      end
  	end

  	def destroy
      @kind.destroy
      redirect_to :controller => :partners,:action => :index
  	end

    private
    def get_kind
      @kind=Kind.find(params[:id])
    end
  end
end
