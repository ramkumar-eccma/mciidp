Myapp::Application.routes.draw do
  scope "(:locale)", :locale => /en|ar/ do
    devise_scope :user do
      root :to => 'devise/sessions#new'
      delete "sign out" => "devise/session#destroy"
    end
    devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: '', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
   
    get "home/index"
    get "home/minor"
    get "langs/show"
    get 'source_data/chart'
    get 'source_data/morensn'
    get 'view_lang' => 'langs#view'
    get 'show_lang' => 'langs#show'
    get 'cage_details' => 'source_data#cage_details'
    get 'update_lang' => 'langs#update'
    post 'update_lang' => 'langs#update'
    get 'source' => 'source_data#source'
    get 'edit' => 'source_data#edit'
    get 'nsnlist' => 'source_data#nsnlist'
    get 'dictionary_detail' => 'source_data#dictionary_detail'
    get 'sourceinv' => 'source_data#sourceinv'
    get 'view' => 'source_data#view'
    get 'viewsource' => 'source_data#viewsource'
    get 'sourceref' => 'source_data#sourceref'
    get "madein_ksa/show"
    get 'show_ksa' => 'madein_ksa#show'
    get 'viewksa' => 'madein_ksa#view'
    post 'image_upload' => 'madein_ksa#view'
    get "exemption/show"
    get 'show_exemption' => 'exemption#show'
    get 'view_exemption' => 'exemption#view'

    get 'detail_view' => 'madein_ksa#detail_view'
    get 'showfactory' => 'madein_ksa#showfactory'
    get 'showclass' => 'madein_ksa#showclass'
    get 'more_details' => 'madein_ksa#more_details'

    get "madein_ksa/show"
    get 'show_ksa' => 'madein_ksa#show'
    post 'view1' => 'madein_ksa#view'
    get 'add_material' => 'madein_ksa#add_material'
    post 'add_material_ksa' => 'madein_ksa#add_material'
    get 'image1' => 'madein_ksa#image'
    get 'get_template_ksa' => 'madein_ksa#get_template'
    post 'get_template1_ksa' => 'madein_ksa#get_template1'
    get 'delete_supp_ksa' => 'madein_ksa#delete_supp'

    get "exemption/show"
    get 'show_exemption' => 'exemption#show'
    get 'view_exemption' => 'exemption#view'
    get 'cleansed' => 'source_data#cleansed'
    get 'editcleansed' => 'source_data#editcleansed'

    get 'settings' => 'madein_ksa#settings'
    post 'settings' => 'madein_ksa#settings'
    get 'template_search' => 'madein_ksa#template_search'
    get 'language' => 'madein_ksa#language'
    post 'language' => 'madein_ksa#language'
    get 'ajax_property' => 'madein_ksa#ajax_property'
    get 'vendor' => 'source_data#vendor'

    get 'advanced_search/listall' 
    post 'advanced_search/listall' 
    post 'advanced_search/getresult'
    get 'advanced_search/advsearch_response' => 'advanced_search#advsearch_response'
    post 'advanced_search/advsearch_response' => 'advanced_search#advsearch_response'

    get 'user/list'
    get 'user/edit' 
    get 'user/update' 
    get 'user/delete' 
    post 'user/update'
    get 'madein_ksa/delete'
    get 'delete' => 'madein_ksa#delete'
    get 'source_data/dashboard'
    get 'source_data/showmap'
    get 'source_data/factory_details'

  end  
end
