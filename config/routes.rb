Rails.application.routes.draw do
  
  get 'users/new'
  get 'static_pages/about'=> 'static_pages#about'
  get 'static_pages/help'=>'static_pages#help'
  get 'static_pages/contact'=>'static_pages#contact'


 root to: 'static_pages#home'
  resources :jobs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
