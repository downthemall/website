Downthemall::Application.routes.draw do
  devise_for :users
  resources :articles, :only => [:index, :create, :new]
  root to: "home#index"
end
