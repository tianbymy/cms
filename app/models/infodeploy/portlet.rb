# -*- coding: utf-8 -*-

module Infodeploy
  class Portlet
    include Mongoid::Document    
    field :title
    field :number ,:type => Integer,:default=>1
    field :option
    field :type ,:type => Integer
    field :logo
    belongs_to :section, :class_name => 'Infodeploy::Section'
    belongs_to :page, :class_name => 'Infodeploy::Page'
=begin
    field :uri
    field :shownumber ,:type => Integer
    field :channel_id
    field :programa_id
=end
    mount_uploader :logo, ImageUploader
    validates_presence_of :title, :message => "不能为空"
    #validates_numericality_of :shownumber, :message => "必须是数字"
    def self.get_portlet_type
      [
        {:id => 1,:value => '新闻类'},
        {:id => 2,:value => '应用类'},
        {:id => 3,:value => '广告位'}
      ]
    end
  end
end
