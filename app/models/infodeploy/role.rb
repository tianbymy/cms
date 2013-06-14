# -*- coding: utf-8 -*-
module Infodeploy
  class Role
    include Mongoid::Document

    has_and_belongs_to_many :users, :inverse_of => :roles, :class_name => 'Infodeploy::User', :autosave => true

    field :name
    field :lock, :type => Boolean
    field :menu_items, :type => Array

#    accepts_nested_attributes_for :right, :reject_if => :all_blank

    validates_presence_of :name, :message => "不能为空"
    validates_uniqueness_of :name, :message => "已存在"

    scope :get_admin, where(:name => "系统管理员")


    def right_exist?(right)
      self.menu_items.include? right unless self.menu_items.nil?
    end

    def user_exist?(user)
      self.users.map(&:uid).include? user
    end

    def is_admin?
      self.name == "系统管理员"
    end

    def self.is_last_admin?
      get_admin.first.users.size >= 2 ? false : true
    end

  end
end
