Rails3MongoidDevise::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  devise_for :users
  resources :items
  resources :users, :only => [:show, :index]
  get '/tags' => 'search#index', :as => 'search'
  root :to => "home#index"
end
