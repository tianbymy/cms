# -*- coding: utf-8 -*-
module Infodeploy
  class Channel
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :createuser
    field :modifyuser
    has_many :programas, :class_name => 'Infodeploy::Programa'
    validates_presence_of :name, :message => "不能为空"
    validates_uniqueness_of  :name, :message => "不能重复"
 
  end
end
