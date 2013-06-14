Infodeploy::Engine.routes.draw do

  root :to => 'dashboard#index'

  resources :admins, :only => [:index] do
    collection do
      get "logout"
    end
  end

  resources :slides,:only => [] do
    collection do
      get 'destroy_image'
    end
  end

  resources :recycles,:only => [:index,:destroy] do
    collection do
      post 'more_dispose'
      post 'recover'
    end
  end

  resources :questions,:only => [:index,:create,:new,:destroy] do
    get 'replies'
    collection do
      delete 'delete_repliy'
    end
  end

  resources :members do
    get 'password_update'
    put 'reset_password'
  end
  resources :search,:only=>[:index]
  resources :article_queries, :only => [] do
    collection do
      post 'attribute_query'
    end
  end

  resources :search_histories

  resources :help, :only => [:index]
  resources :settings, :only => [:index]
  resources :dashboard, :only => [:index]

  resources :roles, :except => [:show]

  resources :users do
    collection do
      get "new_more"
      post "create_more"
      get "sync"
      post 'validate_login'
    end
  end

  resources :advertisements,:only => [:index]

  resources :ads,:only => [] do
    resources :advertisements,:except => [:index] do
      collection do
#        get 'new_default'
#        post 'create_default'
         get 'edit_default'
         put 'update_default'
      end
    end
  end

  resources :business_ad,:only => [:index,:new,:edit,:create,:update,:destroy,:show]

  resources :friendships,:only => [:index,:new,:edit,:create,:update,:destroy]
  resources :partners,:only => [:index]
  resources :kinds,:only => [:index,:new,:edit,:create,:update,:destroy] do
    resources :partners,:only => [:new,:edit,:create,:update,:destroy]
  end

  resources :videos
  resources :knowledges
  resources :properties

  resources :channels,:only => [:index,:edit,:new,:update,:create,:destroy] do
    collection do
      get 'get_all'
    end
    resources :programas,:only => [:new,:create,:edit,:update,:destroy,:index]
  end

  resources :programas,:only => [] do
      collection do
        get "get_by_channel"
        get 'get_by_kinds'
        get 'get_all_by_channel'
      end
    end

  resources :home, :only => [:index,:edit,:update,:new,:create,:destroy] do
    collection do
      get "item"
      get 'managerment'
    end
  end



  resources :navigation ,:only=>[:edit,:new,:update,:create,:destroy] do
    collection do
      get "managerment"
    end
  end
  resources :layout ,:only=>[:edit,:new,:update,:create,:destroy] do
    collection do
      get "managerment"
    end
  end


  resources :page ,:only=>[:edit,:new,:update,:create,:destroy] do
    match "section/new.:number" =>"section#new"
    resources :section,:only=>[:new,:edit,:update,:create,:destroy] do
      resources :portlet ,:only=>[:index,:edit,:new,:update,:create,:destroy] do
        get "move_portlet_top"
        get "move_portlet_bottom"
      end
      collection do
        get "managerment"
      end
    end
   collection do
     get "managerment"
    end
  end

  resources :widgets ,:only=>[:index]

  resources :check, :only => [] do
    collection do
      post "audit"
      get "pass"
      get "fails"
    end
  end

  resources  :comments do
    get "update_status"
  end
  resources :articles do
    get "waiting_audit_show"
    get "draft_show"
    collection do
      post 'send_audit'
      post 'send_more_audit'
      get 'waiting_audit'
      get 'save_and_send_audit'
      get 'deploy'
      post 'more_deploy'
      get 'recycle'
      post 'empty_recycle'
      post 'audit'
      post 'lower_rack'
      get 'get_type_page'
      post 'site_channel'
      post 'edit_channel'
    end
  end

  match "files/uploads/*path" => "gridfs#serve"

end
