# -*- coding: utf-8 -*-
module Infodeploy
  class ChannelsController < ApplicationController
    before_filter :get_channel, :only => [:edit,:update,:destroy]
    def index
      @channels = Channel.all.desc("updated_at")
    end

    def new
      @channel = Channel.new
    end

    def edit
    end

    def create
      @channel = Channel.new(params[:channel])
      @channel[:createuser]=session[:cas_user]
      @channel[:modifyuser]=session[:cas_user]
      if @channel.save
        flash[:channel_info]="频道创建成功"
        redirect_to :action => :index
      else
        render "new"
      end
    end

    def set_enabled
      
    end

    def update
      @channel[:modifyuser]=session[:cas_user]
      if @channel.update_attributes(params[:channel])
        flash[:channel_info]="频道更新成功"
        redirect_to :action => :index
      else
        render "edit"
      end
    end

    def destroy
      flash[:channel_info]=set_destroy_message(@channel)
      if @channel.programas.size == 0
        @channel.destroy
      end
      redirect_to :action => :index
    end

    def get_all
      render(:json => (Channel.all.desc("updated_at")).to_json,:layout => false)
    end

    private
    def get_channel
      @channel = Channel.find(params[:id])
    end

    def set_destroy_message channel
      return "频道:"+channel.name+" 删除成功" if channel.programas.size == 0
      "频道:"+channel.name+" 删除失败,原因:该频道下已有栏目"
    end
  end
end
