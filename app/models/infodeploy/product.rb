# -*- coding: utf-8 -*-
module Infodeploy
  class Product 
  	include Mongoid::Document
  	include Mongoid::Timestamps
    belongs_to :article,:class_name => "Infodeploy::Article"
  	field :title
  	field :organ
  	field :logo
    field :categories,:type => Array,:default => []
    field :consumers,:type => Array,:default => []
    field :content
    field :describes,:type => Array
    field :attachment
    field :video
    mount_uploader :logo, ImageUploader
    mount_uploader :attachment, AttachmentUploader
    mount_uploader :video, VideoUploader
  	validates_presence_of :title,:categories,:consumers,:organ,:logo, :message => "不能为空"

    class << self
      def categories
        ["信用类","抵押类","质押类"]
      end

      def all_consumer
        ["个人","企业"]
      end
    end
  end
end
