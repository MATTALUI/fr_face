Rails.application.routes.draw do
  root 'welcome#index'
  get '/feed', to: 'feed#index'
  get '/users/login', to: 'users#login', as: 'login'
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
