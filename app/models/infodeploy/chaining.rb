# -*- coding: utf-8 -*-
module Infodeploy
  class Chaining 
  	include Mongoid::Document
  	include Mongoid::Timestamps
  	field :name
  	field :path
  	field :kind_id
  	field :number,:type => Integer

  	validates_presence_of :name,:path, :message => "不能为空"
  	validates_numericality_of :number, :message => "必须是数字"

  	scope :get_by_kind,(lambda do |kind_id|
      where(:kind_id => kind_id)
  	end)
  end
end
