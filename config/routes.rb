Rails.application.routes.draw do
 

  match '/about',    to: 'static_pages#about', via: :get
  match '/help',    to: 'static_pages#help', via: :get
  match '/contact',    to: 'static_pages#contact', via: :get

  match '/signup', to: 'users#new',via: :get
  match '/signin', to: 'sessions#new', via: :get
  match '/signout', to: 'sessions#destroy', via: :delete


  root to: 'static_pages#home'
  resources :jobs
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
