$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "infodeploy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "infodeploy"
  s.version     = Infodeploy::VERSION
  s.authors     = ["Jiujun Tang"]
  s.email       = ["Tangjiujun@zhiyisoft.com"]
  s.homepage    = ""
  s.summary     = %q{"Summary of Infodeploy."}
  s.description = %q{"Description of Infodeploy."}

  s.files = Dir["{app,config,db,lib,public}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency "rubycas-client-rails"
  s.add_dependency 'httpclient'
  s.add_dependency 'simple_form'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
