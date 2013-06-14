# -*- coding: utf-8 -*-
module Infodeploy
  class Programa
    include Mongoid::Document
    include Mongoid::Timestamps
    field :name
    field :link
    field :keyword
    field :describe
    field :enabled,:type => Integer, :default=>0
    field :kinds
    field :createuser
    field :modifyuser
    validates_presence_of :name,:kinds, :message => "不能为空"
    belongs_to :channel, :class_name => 'Infodeploy::Channel'
    @kinds=[["文字","text"],["图片","image"],["视频","video"],["链接","link"],["文档","document"],["单页面","page"],["产品","product"],["机构","organ"]]
    @class_name={"text" => Infodeploy::Wordage,"video" => Infodeploy::Wordage,"image" => Infodeploy::Wordage,"link" => Catenate,"document" => Infodeploy::Document,"page" => Infodeploy::Alone,"product" => Infodeploy::Product,"organ" => Infodeploy::Organ}

    def self.make_kinds
      @kinds
    end

    def self.get_class_by_type type
      @class_name[type]
    end

    def get_kinds marked
      if self[:kinds] != nil
        if self[:kinds].include?(marked.to_s) then {:checked => true} end
      end
    end

    def self.get_kinds_name kinds
      if kinds != nil
        new_kinds=""
        @kinds.each do |kind|
          if kinds.include?(kind[1])
            new_kinds+=kind[0]+","
          end
        end
        kind_length=new_kinds.length
        new_kinds[0,(kind_length-1)]
      end
    end

    def self.get_kind_name type
      if type != nil
        new_type = ""
        @kinds.each do |kind|
          if kind[1]==type
            new_type=kind[0]
          end
        end
        new_type
      end
    end
  end
end
