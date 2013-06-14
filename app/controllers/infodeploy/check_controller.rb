# -*- coding: utf-8 -*-
module Infodeploy
  class CheckController < ApplicationController
    def audit
      operate=params[:operate]
      News.find(params[:news_id]).send(operate)
      redirect_to :action => operate
    end

    def pass
      @news = News.where(:state => "success")
    end

    def fails
      @news = News.where(:state => "over")
    end
  end
end
