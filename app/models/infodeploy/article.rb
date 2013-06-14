# -*- coding: utf-8 -*-
module Infodeploy
  class Article
    include Mongoid::Document
    include Mongoid::Timestamps
    field :channel_id
    field :programa_id
    field :state, :type => String
    field :racking,:type => Integer
    field :type
    field :audit_date,:type => Time
    field :creator
    field :auditor
    validates_presence_of :channel_id,:programa_id,:type,:racking,:state, :message => "不能为空"

    scope :get_by_state,(lambda do |state|
      where(:state => state)
    end)

    scope :get_articles,(lambda do |types|
      where(:state => "success",:racking => 1,:type.in => types)
    end)

    state_machine :initial => :new do
      event :draft do
        transition :new => :draft
      end

      event :waiting_audit do
        transition :draft => :waiting
      end

      event :pass do
        transition :waiting => :success
      end

      event :fails do
        transition :waiting => :over
      end
    end

    def make_attribute(object_class,attribute)
      object=object_class.new(attribute[get_class_name(object_class).to_sym])
      object.article_id=self["_id".to_sym]
      object=set_article_by_type(object,attribute,self[:type])
      object
    end

    def update_by(object_class,attribute)
      object=object_class.where(:article_id => self["_id".to_sym]).first
      if object.nil?
        object=make_attribute(object_class,attribute)
        object.save
      else
        object=set_article_by_type(object,attribute,self[:type])
        object.update_attributes(attribute[get_class_name(object_class).to_sym])
      end
      object
    end

    def set_article_by_type object,attribute,type
      return object.make(attribute) if ["text","image","video"].include?(type)
      object
    end

    def get_class_name object_class
      (object_class.name.split("::")[1]).downcase
    end

    def get_class_by_type
      @class_name[self[:type]]
    end

    def get_state
      if self[:racking] == 0
        "下架时间:\n#{self[:updated_at].strftime('%Y-%m-%d %H:%M:%S')}"
      else
        "否"
      end
    end

    def get_operate
      channel=Infodeploy::Channel.find(self.channel_id).name+"|"+Infodeploy::Programa.find(self.programa_id).name
      if ["text","image","video"].count(self.type) == 1
        wordage=Infodeploy::Wordage.where(:article_id => self.id).first
        return "文稿 "+wordage.title
      end
      if self.type == "page"
        return channel+" 单页面 "
      end
      if self.type == "document"
        document=Infodeploy::Document.where(:article_id => self.id).first
        return "文档 "+document.title
      end
      if self.type == "link"
        catenate=Infodeploy::Catenate.where(:article_id => self.id).first
        return "链接 "+catenate.title
      end
    end
  end
end
