Rails.application.routes.draw do

  get 'welcome/about'
  root 'welcome#index'
  devise_for :users

  resources :wikis
  resources :users, only: [:show]
  resources :charges, only: [:new, :create]

  resources :users, only: [] do
    post '/downgrade_account' => 'users#downgrade_account', as: :downgrade
    post '/upgrade_account' => 'users#upgrade_account', as: :upgrade
  end

end
