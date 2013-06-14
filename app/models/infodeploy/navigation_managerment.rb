# -*- coding: utf-8 -*-
module Infodeploy
  class NavigationManagerment 
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name
    field :number,:type => Integer    
    field :url,:type => String
    field :enabled,:type => Integer , :default=>0
    field :openpage,:type => Integer, :default=>0
    field :system ,:type => Integer, :default=>0
    belongs_to :page, :class_name => 'Infodeploy::Page'
    
    validates_presence_of :name,:number,:message => "不能为空"
    validates_uniqueness_of  :name,:message => "不能重复"
  end
end