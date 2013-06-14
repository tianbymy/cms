# -*- coding: utf-8 -*-
module Infodeploy
  class BusinessAdController < ApplicationController
    before_filter :get_ad,:only => [:edit,:update,:show,:destroy]
  	def index
      @business_ads = BusinessAd.where(:state => "success").desc("updated_at").paginate(:page => params[:page], :per_page => 20)
  	end

  	def new
      @business_ad = BusinessAd.new
  	end

  	def create
      @business_ad = BusinessAd.new(params[:business_ad])
      if @business_ad.draf
      	@business_ad.deploy
      	redirect_to :action => :index
      else
        render "new"
      end
  	end

  	def edit
  	end

  	def update
      if @business_ad.update_attributes(params[:business_ad])
      	redirect_to :action => :index
      else
      	render "edit"
      end
  	end

  	def show
  	end

  	def destroy
      @business_ad.destroy
      redirect_to :action => :index
  	end

  	private
  	def get_ad
      @business_ad = BusinessAd.find(params[:id])
  	end
  end
end
