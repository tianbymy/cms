# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dummy::Application.initialize!

# Basic CAS client configuration
require 'rubycas-client-rails'
ssohost = "http://sso.zhiyisoft.com"

CASClient::Frameworks::Rails::Filter.configure(
                                               :cas_base_url  => ssohost,
                                               :login_url     => "#{ssohost}/login",
                                               :logout_url    => "#{ssohost}/logout",
                                               :validate_url  => "#{ssohost}/proxyValidate",
                                               :username_session_key => :cas_user,
                                               :extra_attributes_session_key => :cas_extra_attributes,
                                               :authenticate_on_every_request => true
                                               )
require 'zhiyi-member'

Zhiyi::Member.load("#{Rails.root.to_s}/config/config.yaml")
