# -*- coding: utf-8 -*-
module Infodeploy
  class Kind 
  	include Mongoid::Document
  	include Mongoid::Timestamps
  	field :name
  	field :condition
  	field :number,:type => Integer

  	validates_presence_of :name, :message => "不能为空"
  	validates_numericality_of :number, :message => "必须是数字"
  end
end
