# -*- coding: utf-8 -*-

module Infodeploy
  class Layout
    include Mongoid::Document
    has_many :page, :class_name => 'Infodeploy::Page'
    belongs_to :sections, :class_name => 'Infodeploy::Section'
    field :title
    field :file
    field :areanumber,:type => Integer
    field :system ,:type => Integer, :default=>0
    validates_presence_of :title,:file,:message => "不能为空"
    validates_uniqueness_of  :title,:file,:message => "不能重复"
    def self.get_layouts
      portlets_path="#{Rails.root.to_s}/app/views/templates"
      list=[]
      Dir.glob(portlets_path+"/default*.haml").each  do |file|
        file=File.basename(file)
        list << file
      end
      list.sort
    end
  end
end
