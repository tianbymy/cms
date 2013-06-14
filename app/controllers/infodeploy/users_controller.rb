# -*- coding: utf-8 -*-
module Infodeploy
  class UsersController < ApplicationController
    before_filter :add_current_user, :only => [:create_more]
    before_filter :get_user,:only => [:edit,:update,:destroy]
    def index
      @users = User.all
    end

    def new
      @user = User.new
      @mata_user = MetaUser.find_not_exist
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        redirect_to :action => :index
      else
        render :new
      end
    end

    def update
      if @user.update_attributes(params[:user])
        redirect_to :action => :index
      else
        render 'edit'
      end
    end

    def destroy
      @user.destroy
      redirect_to :action => :index
    end

    def sync
      MetaUser.update_form_remote
      flash[:notice] = "同步远程用户数据成功"
      redirect_to :back
    end

    def new_more
      @role = Role.find(params[:id])
    end

    def create_more
      exist_users = @role.users.map(&:uid)
      # 去除不需要任何操作的用户，留下需要创建或者增加此权限的用户
      unless params[:users].blank?
        ( params[:users] - exist_users ).each do |user_id|
          User.find_or_create_by(:uid => user_id).roles << @role
        end
      end
      # 需要删除此权限的用户
      @need_delete_users = params[:users].blank? ? exist_users : exist_users - params[:users]
      @need_delete_users.each do |user_id|
        Infodeploy::User.delete_user_role_by_uid(user_id, @role)
      end
      redirect_to roles_path
    end

    private
    def add_current_user
      @role = Role.find(params[:role_ids])
      if @role.users.map(&:uid).include?(session[:cas_user])
        params[:users] = params[:users].nil? ? [session[:cas_user]] : params[:users] << session[:cas_user]
      end
      if @role.is_admin? && params[:users].blank?
        flash[:notice] = "请至少保留一个#{@role.name}"
        return redirect_to :back 
      end
    end

    def get_user
      @user = User.find(params[:id])
    end
    
  end
end
