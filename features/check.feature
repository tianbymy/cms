# -*- coding: utf-8 -*-
# language: zh-CN

功能: 新闻审查
    作为网站管理员,我可以审查新闻内容，并决定是否将新闻显示给用户

  背景: 已知用户已经发布一条新闻
    假如 新闻内容如下:
      |   title         |   content                       |   state   |
      |   发布并等待审查的新闻   |  这条新闻你已经发布，正在审查中。。。  |  waiting  |

  场景: 网站管理员审查新闻并通过
    假如 管理员要审查并第一次通过新闻
    当 我访问"/infodeploy/check"
    那么 我应该看到"新闻后台管理首页"
    那么 我应该看到"新闻标题"是"发布并等待审查的新闻"
    当 我点击页面"发布并等待审查的新闻"链接
    那么 我应该看到"新闻内容"是"这条新闻你已经发布，正在审查中。。。"
    那么 我应该看到"通过状态"是"waiting"
    当 我点击页面"通过验证"链接
    那么 我应该看到"通过状态"是"first_passed"

  场景: 网站管理员审查新闻且未能通过
    假如 管理员审查并淘汰一条新闻
    当 我访问"/infodeploy/check"
    那么 我应该看到"新闻后台管理首页"
    那么 我应该看到"新闻标题"是"发布并等待审查的新闻"
    当 我点击页面"发布并等待审查的新闻"链接
    那么 我应该看到"通过状态"是"first_passed"
    当 我点击页面"不能通过"链接
    那么 我应该看到"新闻后台管理首页"
    那么 我应该不能看到"发布并等待审查的新闻"