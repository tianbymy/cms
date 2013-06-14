# -*- coding: utf-8 -*-
module Infodeploy
  class Friendship 
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :name
    field :link
    field :image
    field :enabled,:type => Integer , :default=>0

    mount_uploader :image, ImageUploader

    validates_presence_of :name,:link,:enabled, :message => "不能为空"
    validates_uniqueness_of :name, :message => "不能重复"
  end
end
