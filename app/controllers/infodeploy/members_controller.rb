# -*- coding: utf-8 -*-
module Infodeploy
  class MembersController < ApplicationController
  	def index
  	  @members=Zhiyi::Member::User.all
  	end

  	def new
  	  @member={:uid=> "",:sn => "",:cn => ""}
  	end

  	def destroy
#  	  Zhiyi::Member::User.delete params[:id]
  	  redirect_to :action => :index
  	end

  	def edit
      @member=Zhiyi::Member::User.get_by_uid(params[:id])
      @new_member={:display => @member[:display]}
  	end

    def update
      @member=Zhiyi::Member::User.get_by_uid(params[:id])
      @new_member=params[:member]
      @errors={}
      @errors=validates_presence_of(@errors,@new_member,["display"])
      if @errors.size == 0
        Zhiyi::Member::User.update_info(@member[:uid],@new_member[:display])
        redirect_to :action => :index
      else
        render "edit"
      end
    end

    def password_update
      @member=Zhiyi::Member::User.get_by_uid(params[:member_id])
    end

    def reset_password
      @member=Zhiyi::Member::User.get_by_uid(params[:member_id])
      member=params[:member]
      @errors={}
      @errors=validates_length_of(@errors,member,["userPassword"])
      @errors=validate_password_of(@errors,member["userPassword"],params["repeat_password"])
      if @errors == {}
        Zhiyi::Member::User.reset_password(params[:member_id],member[:userPassword])
        redirect_to :action => :index
      else
        render "password_update"
      end
    end

    def create
      @member=params[:member]
      @errors={}
      @errors=make_errors(@errors,@member,params)
      if @errors == {}
        @member[:displayName]=@member[:sn]+@member[:cn]
        Zhiyi::Member::User.add params[:member]
        redirect_to :action => :index
      else
        render "new"
      end
    end

    private
    def make_errors errors,user,params
      errors=validates_presence_of(errors,user,["uid","sn","cn","userPassword"])
      errors=validates_length_of(errors,user,["userPassword"])
      errors=validate_password_of(errors,user["userPassword"],params["repeat_password"])
      errors=validates_uniqueness_of_uid(errors,user["uid"])
      errors
    end

    def validates_uniqueness_of_uid errors,uid
      if uid != ""
        if Zhiyi::Member::User.exist?(uid)
          errors[:uid] = ["已存在"]
        end
      end
      errors
    end

    def validates_presence_of errors,user,attributes
      attributes.each do |attribute|
        if user[attribute].blank?
          errors[attribute.to_sym] = ["不能为空"]
        end
      end
      errors
    end

    def validates_length_of errors,user,attributes
      attributes.each do |attribute|
        if user[attribute].length < 6
          errors[attribute.to_sym] = ["长度不能小于6"]
        end
      end
      errors
    end

    def validate_password_of errors,password,repeat_password
      if password != nil
        if password != repeat_password
          errors[:userPassword] = ["两次输入不正确"]
        end
      end
      errors
    end
  end
end
