# -*- coding: utf-8 -*-
module Infodeploy
  class HomeManagerment 
  	include Mongoid::Document
    include Mongoid::Timestamps

    field :number,:type => Integer
    field :channel_id
    field :programa_id
    field :amount,:type => Integer

    validates_presence_of :channel_id,:amount, :message => "不能为空"
  end
end
