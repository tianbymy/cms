# -*- coding: utf-8 -*-
module Infodeploy
  class RolesController < ApplicationController
    before_filter :is_right_nil, :only => [:create, :update]
    before_filter :get_role, :only => [:edit,:update,:destroy]

    def index
      @roles = Role.all
    end

    def new
      @role = Role.new
    end

    def create
      @role = Role.new(params[:role])
      if @role.save
        redirect_to :action => :index
      else
        render :action => "new"
      end
    end

    def update
      if @role.update_attributes(params[:role])
        redirect_to :action => :index
      else
        render :action => "edit"
      end
    end

    def destroy
      @role.destroy
      redirect_to :action => :index
    end

    private
    def is_right_nil
      params[:role][:menu_items] ||= nil
    end

    def get_role
      @role = Role.find(params[:id])
    end

  end
end