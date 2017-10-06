# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'users#index'

  devise_for :users

  post 'calls/:id', to: 'calls#connect', as: 'call'

  resources :users do
    post 'call', on: :member, to: 'calls#create'
  end
end
