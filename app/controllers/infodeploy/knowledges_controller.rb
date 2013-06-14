# -*- coding: utf-8 -*-
module Infodeploy
  class KnowledgesController < ApplicationController

    def index
      @knowledge = Knowledge.all
    end

    def new
      @knowledge = Knowledge.new
    end

    def create
      @knowledge= Knowledge.new(params[:knowledge])
      if @knowledge.save
        redirect_to :action => :index
      else
        render "new"
      end
    end

    def destroy
      Knowledge.find(params[:id]).destroy
      redirect_to :action => :index
    end

  end
end
