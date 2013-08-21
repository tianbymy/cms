source 'http://ruby.taobao.org'

# Declare your gem's dependencies in infodeploy.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'mongoid'
gem 'bson_ext'
gem 'carrierwave'
gem 'carrierwave-mongoid',"~> 0.6.0", :require => 'carrierwave/mongoid'
gem 'rails_kindeditor','~> 0.4.0'

gem 'zhiyi-member', :git => 'git@task.zhiyisoft.com:talent/zhiyi/zhiyi-member.git'

gem 'state_machine'
gem 'haml', '3.1.4'
gem 'slim'
gem 'simple_form'
gem 'rubycas-client'
gem "httpclient", "~> 2.2.5"
gem 'will_paginate_mongoid'
gem "jquery-rails"
gem 'sqlite3'

group :test do
    # Pretty printed test output
    gem 'simplecov', :require => false
    gem 'turn', '0.8.2', :require => false
    gem 'database_cleaner'
    gem 'cucumber'
    gem 'cucumber-rails'
    gem 'webrat'
end
