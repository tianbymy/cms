* 说明：  
   1. 使用时删除 app/views/layouts/infodeploy/default.haml 中如下代码：  

            %nav
            %ul
              - Infodeploy::MenuItem.nav.each do |item|
                %li
                  - selected = ((params[:controller] == item[:controller]) and (params[:action] == item[:action]))
                  - if item.include?(:url)
                    %a{href: item[:url]}= item[:descr]
                  - else
                    %a{href: url_for(controller: item[:controller], action: item[:action]), class: (selected ? "selected" : "")}= item[:descr]


   2. 使用时先取消 app/controllers/infodeploy/application_controller.rb 中  before_filter  的注释

### 操作流程

   1. 首次使用先 rake db:seed 初始用户角色数据
   2. 然后创建角色，并分配权限
   3. 然后给用户分配角色
   4. 成功后就可以注销当前用户，并以刚才的用户登录
