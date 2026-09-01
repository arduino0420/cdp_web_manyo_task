Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks
  resources :labels, except: :show

  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create show edit update]

  namespace :admin do
    resources :users
  end
end