# -*- coding: utf-8 -*-
module Infodeploy
  class MenuItem
    class << self
      def nav
        [
         { :descr => "首页", :controller => "infodeploy/dashboard", :action => "index",:target => "_self" },
         { :descr => "频道", :controller => "infodeploy/channels", :action => "index" ,:target => "_self"},
         { :descr => "新建文稿", :controller => "infodeploy/articles", :action => "new" ,:target => "_self"},
         { :descr => "文稿", :controller => "infodeploy/articles", :action => "index" ,:target => "_self"},
         { :descr => "待审文稿", :controller => "infodeploy/articles", :action => "waiting_audit" ,:target => "_self"},
         { :descr => "已发布文稿", :controller => "infodeploy/articles", :action => "deploy" ,:target => "_self"},
         { :descr => "回收站", :controller => "infodeploy/recycles", :action => "index" ,:target => "_self"},
         { :descr => "广告", :controller => "infodeploy/advertisements", :action => "index" ,:target => "_self"},
         { :descr => "招商信息", :controller => "infodeploy/business_ad", :action => "index" ,:target => "_self"},
         { :descr => "友情链接", :controller => "infodeploy/friendships", :action => "index" ,:target => "_self"},
         #{ :descr => "合作伙伴", :controller => "infodeploy/partners", :action => "index" },
         { :descr => "页面", :controller => "infodeploy/page", :action => "managerment" ,:target => "_self"},
         { :descr => "导航", :controller => "infodeploy/navigation", :action => "managerment" ,:target => "_self"},
         { :descr => "设置", :controller => "infodeploy/settings", :action => "index" ,:target => "_self"},
         { :descr => "管理", :controller => "infodeploy/admins", :action => "index" ,:target => "_self"},
         { :descr => "帮助", :controller => "infodeploy/help", :action => "index" ,:target => "_self"},
         { :descr => "网站主页", :url => "/" ,:target => "_blank"}
        ]
      end

      def get_current_url_right(controller, action)
        rights = nil
        nav.each do |item|
          unless item[:controller].blank?
            rights = item[:descr] if item[:controller].include?(controller) && item[:action] == action
          end
        end
        rights
      end

      def items
        [ 
         { :id => "content",:descr => "内容管理" },       
         { :id => "advertising",:descr => "广告管理"},
  #       { :id => "layout",:descr => "布局管理"},
         { :id => "user",:descr => "用户管理"},
         { :id => "system",:descr => "系统管理"}
        ]
      end


      def subitems
        { "content" =>
          [
           { :id => "频道管理", :url => "/infodeploy/channels"},         
           { :id => "已发布", :url => "/infodeploy/articles/deploy"},
           { :id => "新建",:url => "/infodeploy/articles/new"},
           {:id => "草稿",:url => "/infodeploy/articles"},
           {:id => "待审核",:url => "/infodeploy/articles/waiting_audit"},
           { :id => "回收站",:url => "/infodeploy/articles/recycle"}
          ],
    "advertising" =>
        [
           {:id => "广告管理",:url => "/infodeploy/advertisements"},
           {:id => "友情链接",:url => "/infodeploy/friendships"},
           {:id => "合作伙伴",:url => "/infodeploy/partners"},
           {:id => "招商信息",:url => "/infodeploy/business_ad"}
    ],

          "user" => 
          [
            { :id => "用户角色管理",:url => "/infodeploy/user_roles"},
            { :id => "角色管理",:url => "/infodeploy/roles"},
            { :id => "角色权限分配",:url => "/infodeploy/role_rights"},
          ],
          "system"=>
           [
          { :id => "文章属性",:url => "/infodeploy/properties"}
           ],
        }
      end
    end
  
  end
end
           
    

