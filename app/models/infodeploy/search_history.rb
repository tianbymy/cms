# -*- coding: utf-8 -*-
module Infodeploy
  class SearchHistory 
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :keyword
    field :count,:type => Integer

    validates_presence_of :keyword, :message => "不能为空"
  end
end
