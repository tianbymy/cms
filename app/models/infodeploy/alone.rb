# -*- coding: utf-8 -*-
module Infodeploy
  class Alone 
  	include Mongoid::Document
    include Mongoid::Timestamps
    field :article_id
    field :content

    validates_presence_of :content, :message => "不能为空"

    
  end
end
