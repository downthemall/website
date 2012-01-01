Downthemall::Application.routes.draw do
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup' }
  resources :articles do
    resources :article_translations, :path => :translations, :only => :show do
      resources :versions
    end
    resources :article_images, :path => :images, :except => [:index ,:show]
    resources :comments
  end
  match "/donate" => "home#donate"
  root :to => "home#index"
end
