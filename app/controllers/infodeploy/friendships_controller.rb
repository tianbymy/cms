# -*- coding: utf-8 -*-
module Infodeploy
  class FriendshipsController < ApplicationController
    before_filter :get_friendship,:only => [:edit,:update,:destroy]
  	def index
      @friendships=Friendship.all.asc("number")
  	end

  	def new
      @friendship=Friendship.new
  	end

  	def create
      @friendship=Friendship.new(params[:friendship])
      if @friendship.save
        redirect_to :action => :index
      else
        render "new"
      end
  	end

  	def edit
  	end

  	def update
      if @friendship.update_attributes(params[:friendship])
        redirect_to :action => :index
      else
      	render "edit"
      end
  	end

  	def destroy
      @friendship.destroy
      redirect_to :action => :index
  	end

    private
    def get_friendship
      @friendship=Friendship.find(params[:id])
    end
  end
end
