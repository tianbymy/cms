Rails.application.routes.draw do

  mount Infodeploy::Engine => "/infodeploy"
  match "/kindeditor/upload" => "kindeditor/assets#create"
  match '*path', :to => 'infodeploy/application#render_404'
end
