Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'

  resources :articles
  resources :categories, except: [:show]

  resources :users, except: [:new]
  get 'signup', to: 'users#new'

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
end
