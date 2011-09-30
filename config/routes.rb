Downthemall::Application.routes.draw do
  devise_for :users
  resources :articles do
    resources :translations, :controller => :article_translations, :only => :show
  end
  root :to => "home#index"
end
