# -*- coding: utf-8 -*-

假如 /^新闻内容如下:$/ do |table|
  table.hashes.each do |hash|
    all_news = Infodeploy::News.create(hash)
  end
end

假如 /^我要发布一条新闻$/ do
end

当 /^我访问"([^"]*)"$/ do |arg1|
  visit arg1
end

那么 /^我应该看到"([^"]*)"$/ do |arg1|
  assert page.has_content?(arg1)
end

当 /^我点击页面"([^"]*)"链接$/ do |arg1|
  click_link arg1
end

那么 /^我应该看到新闻标题是"([^"]*)"$/ do |arg1|
  assert page.has_content?(arg1)
  @news = Infodeploy::News.where(title: arg1).last
end

当 /^我点击对应新闻"([^"]*)"链接$/ do |arg1|
  visit "/infodeploy/news/" + @news.id.to_s
end

当 /^我在"([^"]*)"中填入"([^"]*)"$/ do |arg1, arg2|
  fill_in arg1,:with => arg2
end

当 /^我点击页面"([^"]*)"按钮$/ do |arg1|
  click_button arg1
end

那么 /^我应该看到"([^"]*)"是"([^"]*)"$/ do |arg1, arg2|
  assert page.has_content?(arg1)
  assert page.has_content?(arg2)
end

那么 /^我应该不能看到"([^"]*)"链接$/ do |arg1|
  assert page.has_no_content?(arg1)
end
