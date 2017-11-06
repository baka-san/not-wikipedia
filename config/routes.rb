Rails.application.routes.draw do

  get 'welcome/about'
  root 'welcome#index'
  devise_for :users

  resources :wikis

  resources :charges, only: [:new, :create]

end
