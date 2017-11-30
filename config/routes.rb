Rails.application.routes.draw do
  get 'stripe/webhooks'

  get 'welcome/about'
  root 'welcome#index'
  devise_for :users

  resources :wikis
  resources :users, only: [:show]
  resources :subscriptions, only: [:new, :create]

  post '/turn_on_autopay' => 'subscriptions#turn_on_autopay', as: :turn_on_autopay
  post '/turn_off_autopay' => 'subscriptions#turn_off_autopay', as: :turn_off_autopay


  resources :users, only: [] do
    post '/upgrade_account' => 'users#upgrade_account', as: :upgrade
    get 'user_settings' => 'user_settings#show'
  end

  post '/stripe/webhooks', to: "stripe#webhooks"

end
