# -*- coding: utf-8 -*-
# language: zh-CN

功能: 新闻发布修改
    作为新闻发布者,我可以发布、查看、修改自己发布的新闻

  背景: 已知用户已经发布一条新闻
    假如 新闻内容如下:
      |   title         |       content                          |  state       |
      |   等待审查的新闻   |  这条新闻你已经发布，正在审查中。。。         |              |
      |   没有通过的新闻   |  这条新闻未能通过的审查，请修改后重新发布      |  fail_pass   |
      |   成功通过的新闻   |  这条新闻已经成功通过审查，你可以在首页查看它   | third_passed |

  场景大纲: 从用户新闻首页发布一条新闻
    假如 我要发布一条新闻
    当 我访问"/infodeploy/news"
    那么 我应该看到"新闻列表"
    当 我点击页面"发布新闻"链接
    那么 我应该看到"发布新闻"
    当 我在"news_title"中填入"<title>"
    当 我在"news_content"中填入"<content>"
    当 我点击页面"发布新闻"按钮
    那么 我应该看到"新闻发布成功"
    那么 我应该看到"新闻标题"是"<title>"
    那么 我应该看到"新闻内容"是"<content>"
    那么 我应该看到"通过状态"是"新闻审查中.."

    例子:
      |   title         |   content                       |
      |   等待审查的新闻   |  这条新闻你已经发布，正在审查中。。。  |

  场景: 查看刚发布的新闻
    当 我访问"/infodeploy/news"
    那么 我应该看到"新闻列表"
    那么 我应该看到新闻标题是"等待审查的新闻"
    那么 我应该看到"通过状态"是"新闻审查中.."
    当 我点击对应新闻"详细信息"链接
    那么 我应该看到"新闻内容"是"这条新闻你已经发布，正在审查中。。。"
    而且 我应该不能看到"修改新闻"链接

  场景: 修改未通过的新闻
    当 我访问"/infodeploy/news"
    那么 我应该看到新闻标题是"没有通过的新闻"
    那么 我应该看到"通过状态"是"新闻未能通过!"
    当 我点击对应新闻"详细信息"链接
    那么 我应该看到"修改新闻"
    当 我点击页面"修改新闻"链接
    那么 我应该看到"编辑新闻"
    当 我在"news_content"中填入"这条新闻已经被修改好了。。"
    当 我点击页面"发布新闻"按钮
    那么 我应该看到"新闻修改成功"
    那么 我应该看到"新闻内容"是"这条新闻已经被修改好了。。"
    那么 我应该看到"通过状态"是"新闻审查中.."
