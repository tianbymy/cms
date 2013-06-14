# -*- coding: utf-8 -*-
module Infodeploy
  class BusinessAd 
  	include Mongoid::Document
    include Mongoid::Timestamps
    field :title
    field :content
    field :enterprise
    field :contactor
    field :contact_method
    field :end_date,:type => Time
    field :industry
    field :state

    validates_presence_of :title,:content, :enterprise,:end_date,:contact_method,:contactor,:industry, :message => "不能为空"
    validates_numericality_of :contact_method, :message => "必须是数字"
    state_machine :initial => :new do

      event :draf do
        transition :new => :draf
      end

      event :deploy do
        transition :draf => :success
      end

      event :fails do
        transition :draf => :over
      end

    end

    def self.industries
      [["计算机/互联网/通信/电子","计算机/互联网/通信/电子"],
      ["会计/金融/银行/保险","会计/金融/银行/保险"],
      ["贸易/消费/制造/营运","贸易/消费/制造/营运"],
      ["制药/医疗","制药/医疗"],
      ["广告/媒体","广告/媒体"],
      ["房地产/建筑","房地产/建筑"],
      ["专业服务/教育/培训","专业服务/教育/培训"],
      ["服务业","服务业"],
      ["物流/运输","物流/运输"],
      ["能源/原材料","能源/原材料"],
      ["政府/非赢利机构/其他","政府/非赢利机构/其他"]]
    end
  end
end
