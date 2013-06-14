source 'https://rubygems.org'

# Declare your gem's dependencies in infodeploy.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'mongoid'
gem 'bson_ext'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'rails_kindeditor','~> 0.3.0'

gem 'zhiyi-member', :git => 'git@task.zhiyisoft.com:talent/zhiyi/zhiyi-member.git'

gem 'state_machine'
gem 'haml', '3.1.4'
gem 'slim'
gem 'simple_form'
gem 'rubycas-client'
gem "httpclient", "~> 2.2.5"
gem 'will_paginate_mongoid'
group :test do
    # Pretty printed test output
    gem 'simplecov', :require => false
    gem 'turn', '0.8.2', :require => false
    gem 'database_cleaner'
    gem 'cucumber'
    gem 'cucumber-rails'
    gem 'webrat'
end

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'