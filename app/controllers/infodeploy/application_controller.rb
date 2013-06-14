# -*- coding: utf-8 -*-

module Infodeploy
  class ApplicationController < ActionController::Base
    before_filter CASClient::Frameworks::Rails::Filter, :if => Proc.new{|c| c.request.url.include? "infodeploy" if c.session[:cas_user].nil?}
    before_filter :chcke_right
    layout "infodeploy/default"

    def chcke_right
      rights = Infodeploy::User.find_rights(session[:cas_user])
      unless params[:controller].eql?("infodeploy/comments")
        if rights.blank?
          render :text => "你目前没有任何权限,请与系统管理员联系"
        else
          right = Infodeploy::MenuItem.get_current_url_right(self.controller_name, self.action_name)
          render :text => "你没有权限访问此页面,请访问其他页面" unless right.nil? || rights.include?(right)
        end
      end
    end

    def render_404(exception = nil)
      if exception
          logger.info "Rendering :404 => #{exception.message}"
      end
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end

  end
end
