# -*- coding: utf-8 -*-

module Infodeploy
  class Comment

    include Mongoid::Document
    include Mongoid::Timestamps

    field :actor
    field :content
    field :status,:default=>0
    validates_presence_of :content
    belongs_to :article, :class_name =>"Infodeploy::Article"
  end
end
