Downthemall::Application.routes.draw do
  scope ':locale' do
    resources :posts, path: :news
    resources :revisions, path: :"knowledge-base" do
      member do
        get :approve
      end
    end
    resource :image_assets, only: [:create]
    resources :donations, only: [:create] do
      member do
        post :complete
        get :cancel
      end
    end
    post 'sign_in' => 'sessions#create'
    post 'sign_out' => 'sessions#destroy'
    get 'force_sign_in' => 'sessions#force_sign_in' if Rails.env.test?
    post 'paypal_notify' => 'donations#paypal_notify'
    get 'donate' => 'donations#new', as: :donate
    get 'features' => 'static#features', as: :features
    root to: 'static#homepage'
  end

  root to: 'static#homepage'
end

