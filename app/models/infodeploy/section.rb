# -*- coding: utf-8 -*-

module Infodeploy
  class Section
    include Mongoid::Document
    #has_and_belongs_to_many :portlets, :inverse_of => nil, :class_name => 'Infodeploy::Portlet'
    has_many :portlets, :class_name => 'Infodeploy::Portlet'
    belongs_to :page, :class_name => 'Infodeploy::Page'
    
    field :number, :type => Integer
    validates_numericality_of :number, :message => "必须是数字"
    validates_presence_of :number, :message => "不能为空"


    
    def self.get_areas page_id
      @area=Section.where(:page_id=>page_id)
    end
    def self.get_area_portlets number,page_id
      @portlets=Section.where(:page_id=>page_id).where(:number=>number)
    end
    def self.get_portlet(portlet_id)
      @portlet = Infodeploy::Portlet.find(portlet_id)
    end
  end
end
