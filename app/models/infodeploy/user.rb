# -*- coding: utf-8 -*-
module Infodeploy
  class User
    include Mongoid::Document

    before_validation :generate_name

    has_and_belongs_to_many :roles, :inverse_of => :users, :class_name => 'Infodeploy::Role', :autosave => true

    field :name
    field :uid

    validates_presence_of :name, :uid, :message => "不能为空"
    validates_uniqueness_of :uid, :message => "已存在"

    scope :find_by_uid,(lambda do | user_id | where(:uid => user_id) end)

    def generate_name
      mata_user = MetaUser.get_by_uid(uid).first
      self.name = mata_user.name unless mata_user.blank?
    end

    def is_admin?
      self.roles.map(&:name).include? "系统管理员"
    end

    def self.delete_user_role_by_uid (user_id, role)
      user = where(:uid => user_id).first
      role_ids = user.role_ids
      role_ids.delete(role.id)
      if role_ids.blank?
        user.destroy
      else
        user.update_attributes(:role_ids => role_ids)
      end
    end

    def self.find_rights user_id
      unless find_by_uid( user_id ).first.blank?
        rights = []
        find_by_uid( user_id ).first.roles.each do |role| 
           rights = rights | role.menu_items unless role.menu_items.blank?
        end
        rights
      end
    end

  end
end
