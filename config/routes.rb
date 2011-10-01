Downthemall::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }
  resources :articles do
    resources :translations, :controller => :article_translations, :only => :show
  end
  root :to => "home#index"
end
