Impstore::Application.routes.draw do

  resources :users, :only => [:new, :create]
  resource :cart, :only => [:create, :update, :show, :destroy]
  resources :sessions, :only => [:create, :destroy]
  resources :items, :only => [:index, :show]

  root :to => 'items#index'
end
