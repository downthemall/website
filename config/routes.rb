Downthemall::Application.routes.draw do
  devise_for :users
  resources :articles, :except => :show
  root :to => "home#index"
end
