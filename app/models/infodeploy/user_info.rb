# -*- coding: utf-8 -*-
module Infodeploy
  class UserInfo 
  	include Mongoid::Document
    include Mongoid::Timestamps
    field :uid
    field :email
    field :type
  end
end
