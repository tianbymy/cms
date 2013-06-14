# -*- coding: utf-8 -*-
module Infodeploy
  class Ask 
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :content
    field :person
    field :question_id

    validates_presence_of :content, :message => "不能为空"
  end
end
