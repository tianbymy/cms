# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dummy::Application.initialize!

# Basic CAS client configuration
require 'rubycas-client-rails'

CASClient::Frameworks::Rails::Filter.configure(
         :cas_base_url  => "http://127.0.0.1:8080",
         :login_url     => "http://127.0.0.1:8080/login",
         :logout_url    => "http://127.0.0.1:8080/logout",
         :validate_url  => "http://127.0.0.1:8080/proxyValidate",
         :username_session_key => :cas_user,
         :extra_attributes_session_key => :cas_extra_attributes,         
         :authenticate_on_every_request => true
         )
require 'zhiyi-member'

Zhiyi::Member.load("#{Rails.root.to_s}/config/config.yaml")