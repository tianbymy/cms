# -*- coding: utf-8 -*-
module Infodeploy
  class Partner 
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :name
    field :link
    field :number
    field :condition
    field :kind_id

    validates_presence_of :name,:link,:condition, :message => "不能为空"
  	validates_numericality_of :number, :message => "必须是数字"
    validates_uniqueness_of  :name,:message => "不能重复"
  end
end
