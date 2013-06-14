# -*- coding: utf-8 -*-
module Infodeploy
  class Catenate 
  	include Mongoid::Document
  	include Mongoid::Timestamps
  	field :title
  	field :path
  	field :logo
  	field :enabled
  	field :article_id
    mount_uploader :logo, ImageUploader
  	validates_presence_of :title,:path, :message => "不能为空"

    
  end
end
