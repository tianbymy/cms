# -*- coding: utf-8 -*-
module Infodeploy
  class Question 
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :content
    field :person

    validates_presence_of :content, :message => "不能为空"
  end
end
