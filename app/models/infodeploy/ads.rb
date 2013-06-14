# -*- coding: utf-8 -*-
module Infodeploy
  class Ads
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :number,:type => Integer
    field :size,:type => Integer
    field :description
    def self.get_size 
      [
        {:id => 1,:size => "960x170",:description => "二级页面大图"},
        {:id => 2,:size => "310x160",:description => "二级页面广告"},
        {:id => 3,:size => "960x130",:description => "首页广告"},
        {:id => 4,:size => "960x100",:description => "首页广告"},
        {:id => 5,:size => "310x200",:description => "二级页面广告"},
        {:id => 5,:size => "310x240",:description => "示范风采广告"}
        
      ]
    end

    def self.get_size_by ad
      size=""
      get_size.each do |ads|
        if ads[:id] == ad.size
          size=ads[:size]
        end
      end
      size
    end
  end
end
