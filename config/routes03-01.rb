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
    # new routes
     get 'detail_view' => 'madein_ksa#detail_view'
    get 'showfactory' => 'madein_ksa#showfactory'
    get 'showclass' => 'madein_ksa#showclass'
    get 'more_details' => 'madein_ksa#more_details'
    #post 'view1' => 'madein_ksa#image'
     get "madein_ksa/show"
    get 'show_ksa' => 'madein_ksa#show'
    get 'viewksa' => 'madein_ksa#view'
        post 'view1' => 'madein_ksa#image_params'
        get 'add_material' => 'madein_ksa#add_material'
        post 'add_material_ksa' => 'madein_ksa#add_material'
        get 'image1' => 'madein_ksa#image'

     get "exemption/show"
    get 'show_exemption' => 'exemption#show'
    get 'view_exemption' => 'exemption#view'
    get 'cleansed' => 'source_data#cleansed'
    get 'editcleansed' => 'source_data#editcleansed'

     #get 'settings' => 'exemption#settings'
   # post 'settings' => 'exemption#settings'
     get 'settings' => 'madein_ksa#settings'
    post 'settings' => 'madein_ksa#settings'

    #   get 'cage_details' => 'source_data#cage_details'
    #  get 'update_lang' => 'langs#update'
    #  post 'update_lang' => 'langs#update'
    #  get 'source' => 'source_data#source'
    #  get 'edit' => 'source_data#edit'
    #  get 'nsnlist' => 'source_data#nsnlist'
    #  get 'dictionary_detail' => 'source_data#dictionary_detail'
    #  get 'sourceinv' => 'source_data#sourceinv'
    #  get 'view' => 'source_data#view'
    #  get 'viewsource' => 'source_data#viewsource'
    #  get 'sourceref' => 'source_data#sourceref'
    #  get 'cleansed' => 'source_data#cleansed'
    #  get 'editcleansed' => 'source_data#editcleansed'
    #  get "madein_ksa/show"
    # get 'show_ksa' => 'madein_ksa#show'
    # get 'viewksa' => 'madein_ksa#view'
    #   post 'view1' => 'madein_ksa#image'
    # post 'image_upload' => 'madein_ksa#view'
    # get "exemption/show"
    # get 'show_exemption' => 'exemption#show'
    # get 'view_exemption' => 'exemption#view'
    # get 'detail_view' => 'madein_ksa#detail_view'
    # get 'more_details' => 'madein_ksa#more_details'
    # get 'showclass' => 'madein_ksa#showclass'
    # get 'showfactory' => 'madein_ksa#showfactory'
     #post 'update' => 'langs#update'

    # get "home/index"
    # get "home/minor"

    # get 'langs/show'
    # get 'langs/view'
    # get 'langs/update'

    # get 'madein_ksa/show'
    # get 'madein_ksa/view'

    # get 'source_data/chart'
    # get 'source_data/nsnlist'
    # get 'source_data/source'
    # get 'source_data/sourceref'
    # get 'source_data/sourceinv'
    # get 'source_data/edit'
    # get 'source_data/dictionary_detail'
    # get 'source_data/view'
    # get 'source_data/viewsource'
    # get 'source_data/cage_details'
  end
end
