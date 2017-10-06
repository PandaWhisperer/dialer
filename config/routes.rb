# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'users#index'

  devise_for :users

  resources :users, only: :call do
    post 'call', on: :member
  end

  resources :calls, only: :show
end
