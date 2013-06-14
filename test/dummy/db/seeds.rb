# coding: utf-8  
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Infodeploy::MetaUser.update_form_remote
role = Infodeploy::Role.create!(name: Infodeploy::MenuItem.config[:system_admin_name], lock: 1)
role.menu_items = Infodeploy::MenuItem.nav.map{ |item| item[:descr] }
role.save
["suyu", "xiegang", "yangjunfeng", "chenjianbin", "yangdan","tangjiujun"].each do |user_id|
  role.users.create!(uid: user_id)
end
role1 = Infodeploy::Role.create(name: '文稿审核员', lock: 1)
role2 = Infodeploy::Role.create(name: '文稿录入员', lock: 1)