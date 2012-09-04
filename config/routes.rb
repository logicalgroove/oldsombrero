Rails3MongoidDevise::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  devise_for :users
  resources :items
  resources :users, :only => [:show, :index]
  get '/search' => 'search#index', :as => 'search'
  get '/tag/:name' => 'tags#show', :as => 'tag'
  root :to => "home#index"
end
