# -*- coding: utf-8 -*-
module Infodeploy
  class Knowledge
    include Mongoid::Document
    include Mongoid::Timestamps
    field :title
    field :attachment
    field :description
    field :knowledge_type
    field :number,:type => Integer

    # mount the uploader
    mount_uploader :attachment, AttachmentUploader

    #validates
    validates_presence_of :title,:attachment,:description,:knowledge_type,:number,:message => "不能为空"
    validates_numericality_of :number, :message => "必须是数字"
  end
end
