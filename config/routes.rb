Rails3MongoidDevise::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}
  resources :items
  resources :users, :only => [:show, :index]
  get '/search' => 'search#index', :as => 'search'
  get '/tag/:name' => 'tags#show', :as => 'tag'
  match '/follow_user/:id' => 'follow#follow_user', :as => 'follow_user'
  match '/follow_tag/:id' => 'follow#follow_tag', :as => 'follow_tag'
  root :to => "home#index"
end
