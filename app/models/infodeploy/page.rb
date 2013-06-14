# -*- coding: utf-8 -*-

module Infodeploy
  class Page
    include Mongoid::Document
    has_many :sections, :class_name => 'Infodeploy::Section'
    belongs_to :layout, :class_name => 'Infodeploy::Layout'
    has_many :navigation, :class_name => 'Infodeploy::NavigationManagerment'
    has_many :portlet,:class_name =>"Infodeploy::Portlet"
    field :title
    field :system ,:type => Integer, :default=>0
    validates_presence_of :title, :message => "不能为空"
    validates_uniqueness_of  :title, :message => "不能重复"
  end
end
