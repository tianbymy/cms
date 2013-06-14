# -*- coding: utf-8 -*-
module Infodeploy
  class MetaUser
    include Mongoid::Document

    field :name
    field :uid

    validates_presence_of :name, :uid, :message => "不能为空"
    validates_uniqueness_of :uid, :message => "已存在"


    def self.update_form_remote
      users = Zhiyi::Member::User.all
      self.destroy_all unless users.blank?
      users.map{ |user| self.create(:name => user[:display],:uid => user[:uid]) }
    end

    def self.find_all
      all.only(:uid, :name).map{ |user| [user.name, user.uid]}
    end

    def self.find_not_exist
      exist_uid = User.all.only(:uid, :name).map{ |user| [user.name, user.uid]}
      find_all - exist_uid
    end

    scope :get_by_uid, lambda{ |user_id| where(:uid => user_id) }

  end
end
