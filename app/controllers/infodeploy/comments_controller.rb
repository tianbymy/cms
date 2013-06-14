# -*- coding: utf-8 -*-
module Infodeploy
  class CommentsController < ApplicationController

    def index
      @comments = Comment.all.desc("created_at")
    end

    def show
      @comment = Comment.find(params[:id])
    end

    def new
      @comment = Comment.new
      render :layout => false
    end

    def create
      @comment = Comment.new(params[:comment])
      @comment[:actor]= session[:cas_user]
      if @comment.save
        render :json =>'{"stats": 200,"message": "成功"}'
      else
        render :json =>'{"stats": 400,"message": "失败"}'
      end
    end

    def edit
    end

    def update_status
      @comment = Comment.find(params[:comment_id])
      if @comment.update_attribute(:status, 1)
        redirect_to :back
        #render :json=>'{"stats": "200","message": "成功"}'
      else
        redirect_to :back
        #render :json=>'{"stats": "400","message": "失败"}'
      end

    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to :back
    end


    end
end
