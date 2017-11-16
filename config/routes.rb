Rails.application.routes.draw do
  get 'stripe/webhooks'

  get 'welcome/about'
  root 'welcome#index'
  devise_for :users

  resources :wikis
  resources :users, only: [:show]
  resources :subscriptions, only: [:new, :create]

  resources :users, only: [] do
    post '/downgrade_account' => 'users#downgrade_account', as: :downgrade
    post '/upgrade_account' => 'users#upgrade_account', as: :upgrade
    get 'user_settings' => 'user_settings#show'
  end

  post '/stripe/webhooks', to: "subscriptions#webhooks"

end
