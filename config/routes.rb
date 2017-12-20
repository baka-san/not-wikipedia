Rails.application.routes.draw do
  get 'stripe/webhooks'
  post '/stripe/webhooks', to: "stripe#webhooks"

  get 'welcome/about'
  root 'welcome#index'

  devise_for :users
  resources :users, only: [:show]

  resources :users, only: [] do
    get 'user_settings' => 'user_settings#show'
    # get 'wikis' => 'users#wikis'
    # resources :wikis, only: [:index]
  end

  resources :wikis

  resources :wikis, only: [] do
    resources :collaborations, only: [:index, :create, :destroy]
  end
  
  resources :subscriptions, only: [:new, :create]

  post '/turn_on_autopay' => 'subscriptions#turn_on_autopay', as: :turn_on_autopay
  post '/turn_off_autopay' => 'subscriptions#turn_off_autopay', as: :turn_off_autopay





end
