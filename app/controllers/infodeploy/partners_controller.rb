# -*- coding: utf-8 -*-
module Infodeploy
  class PartnersController < ApplicationController
  	before_filter :get_kind,:except => [:index]
    before_filter :get_partner,:only => [:edit,:update,:destroy]
  	def index
      @kinds=Kind.all.asc("number")
  	end

  	def new
      @partner=Partner.new
  	end

  	def create
      @partner=Partner.new(params[:partner])
      @partner.kind_id = @kind.id
      if @partner.save
        redirect_to :action => :index
      else
        render "new"
      end
  	end

  	def edit
  	end

  	def update
      if @partner.update_attributes(params[:partner])
        redirect_to :action => :index
      else
      	render "edit"
      end
  	end

  	def destroy
      @partner.destroy
      redirect_to :action => :index
  	end

  	private
  	def get_kind
      @kind=Kind.find(params[:kind_id])
  	end

    def get_partner
      @partner=Partner.find(params[:id])
    end
  end
end
