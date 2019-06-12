Rails.application.routes.draw do

  
  get 'static_pages#home'
  get 'static_pages#about'
  get 'static_pages#help'
  get 'static_pages#contact'


 root to: 'static_pages#home'

 

  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  resources :jobs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
