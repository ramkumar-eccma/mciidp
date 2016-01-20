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
