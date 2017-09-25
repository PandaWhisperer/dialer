Rails.application.routes.draw do

  root 'users#index'
  resources :users, only: :call do
    post 'call', on: :member
  end
  resources :calls, only: :show
  post 'calls/:id', to: 'calls#show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
