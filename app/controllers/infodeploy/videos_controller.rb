# -*- coding: utf-8 -*-
module Infodeploy
  class VideosController < ApplicationController

    def index
      @videos = Video.all
    end

    def show
    end

    def new
      @video = Video.new
    end

    def create
      @video= Video.new(params[:video])
      if @video.save
        redirect_to :action => :index
      else
        render "new"
      end
    end

    def destroy
      @video = Video.find(params[:id])
      @video.destroy
      redirect_to :action => :index
    end

  end
end
