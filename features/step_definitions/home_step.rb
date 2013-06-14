# -*- coding: utf-8 -*-

假如 /^管理员要审查并通过一条新闻$/ do
end

那么 /^我应该不能看到"([^"]*)"$/ do |arg1|
  page.has_no_content? arg1
end
