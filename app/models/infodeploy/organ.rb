# -*- coding: utf-8 -*-
module Infodeploy
  class Organ 
  	include Mongoid::Document
  	include Mongoid::Timestamps
    belongs_to :article,:class_name => "Infodeploy::Article"
  	field :title
  	field :logo
    field :overview
    field :categories,:type => Array,:default => []
    field :content
    field :attachment
    field :video
    mount_uploader :logo, ImageUploader
    mount_uploader :attachment, AttachmentUploader
    mount_uploader :video, VideoUploader
  	validates_presence_of :title,:categories,:logo,:overview,:content, :message => "不能为空"

    class << self
      def categories
        ["信用类","抵押类","质押类"]
      end
    end
  end
end
