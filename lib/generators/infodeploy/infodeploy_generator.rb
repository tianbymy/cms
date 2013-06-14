# Requires
require 'rails/generators'
require 'rails/generators/migration'


class InfodeployGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end


  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.new.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end


# 复制数据迁移文件到 主项目中
  def create_migration_file
    # migration_template 'migration.rb', 'db/migrate/create_news_table.rb'
  end

  def copy_initializer_file
    copy_file "carrierwave.rb", "config/initializers/carrierwave.rb"
    copy_file "rails_kindeditor.rb", "config/initializers/rails_kindeditor.rb"
    copy_file "mongoid.yml", "config/mongoid.yml"

  end

end
