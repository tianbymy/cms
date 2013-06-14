# -*- coding: utf-8 -*-
module Infodeploy
  class Document 
  	include Mongoid::Document
  	include Mongoid::Timestamps
  	field :title
  	field :content
  	field :article_id
  	field :overview
  	mount_uploader :content, AttachmentUploader
  	validates_presence_of :title,:content,:overview, :message => "不能为空"

    
  end
end
