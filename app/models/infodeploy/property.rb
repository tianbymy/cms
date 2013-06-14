# -*- coding: utf-8 -*-
module Infodeploy
  class Property 
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :name
    field :marked
    field :system ,:type => Integer, :default=>0
    validates_presence_of :name,:marked, :message => "不能为空"
    validates_uniqueness_of :marked,:message => "已存在"
  end
end
