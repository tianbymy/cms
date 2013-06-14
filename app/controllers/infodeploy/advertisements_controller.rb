# -*- coding: utf-8 -*-
module Infodeploy
  class AdvertisementsController < ApplicationController
    before_filter :get_ad, :only => [:edit_default,:update_default]
    before_filter :make_ad, :only => [:edit_default,:update_default]
    def index
      @ads=Ads.all.asc("number")
    end

    def edit_default
    end

    def update_default
      @advertisement=site_default_date(@advertisement)
      @advertisement.save
      if @advertisement.update_attributes(params[:advertisement])
        redirect_to :action => :index
      else
        render "edit_default"
      end
    end

    def show
      @advertisement = Advertisement.find(params[:id])
    end

    def new
      @ad=Ads.find(params[:ad_id])
      @advertisement = Advertisement.new
    end
    
    def create
      @ad=Ads.find(params[:ad_id])
      @advertisement = Advertisement.new(params[:advertisement])
      @advertisement.number = Advertisement.where(:ads_id=>params[:ad_id]).size
      @advertisement.ads_id = params[:ad_id]
      @advertisement.name = "广告"
      @advertisement.condition=1
      if @advertisement.save
          redirect_to :action => :index
      else
        render 'new'
      end
    end

    def edit
      @ad=Ads.find(params[:ad_id])
      @advertisement = Advertisement.find(params[:id])
    end

    def update
      @ad=Ads.find(params[:ad_id])
      @advertisement = Advertisement.find(params[:id])
      if @advertisement.update_attributes(params[:advertisement])
        redirect_to :action => :index
      else
        render "edit"
      end
    end

    def destroy
      @advertisement = Advertisement.find(params[:id])
      @advertisement.destroy
      redirect_to :back
    end

    def site_default_date ad
      ad.name="默认"
      ad.number=0
      ad.condition=0
      ad.start_date=Date.new
      ad.end_date=Date.new
      ad.contactor="admin"
      ad.contact_method="scscfw@163.com"
      ad
    end

    private
    def get_ad
      @advertisement=Advertisement.where(:ads_id=>params[:ad_id],:number=>0).first
    end

    def make_ad
      return @advertisement=Advertisement.new(:ads_id=>params[:ad_id],:number=>0) if @advertisement.nil?
      @advertisement
    end
  end
end
