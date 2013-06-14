# -*- coding: utf-8 -*-
module Infodeploy
  class Slide 
  	include Mongoid::Document
    include Mongoid::Timestamps
    field :image
    field :article_id
    field :describe
    mount_uploader :image, ImageUploader
    def self.save_picture slide,article_id
      if slide != nil
      	slide["image"].each do |picture|
          if picture["describe"] != ""
      	    Slide.new(:article_id => article_id,:image => picture["name"],:describe => picture["describe"]).save
          end
      	end
      end
    end
  end
end
