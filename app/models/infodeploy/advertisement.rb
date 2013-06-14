# -*- coding: utf-8 -*-
module Infodeploy
  class Advertisement
    # attr_accessible :title, :body
    include Mongoid::Document
    include Mongoid::Timestamps
    field :name
    field :image
    field :start_date,:type => Time
    field :end_date,:type => Time
    field :number,:type => Integer
    field :condition,:type => Integer
    field :link
    field :contactor
    field :contact_method
    field :ads_id
    validates_presence_of :image, :message => "不能为空"
    validate :validate_by_number
    mount_uploader :image, ImageUploader
    
    
    validates_numericality_of :number, :only_integer => true
    
    def validate_by_number
      if self.number != 0
        validates_presence_of :start_date,:end_date,:contact_method,:contactor,:link, :message => "不能为空"
      end
    end
    def out_of_date
      now_time=Time.now.strftime('%Y-%m-%d %H:%M:%S').to_time.to_i
      if self[:start_date].strftime('%Y-%m-%d %H:%M:%S').to_time.to_i <= now_time && self[:end_date].strftime('%Y-%m-%d %H:%M:%S').to_time.to_i >= now_time
        true
      else
        false
      end
    end
  end
end
