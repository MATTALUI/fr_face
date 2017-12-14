Rails.application.routes.draw do
  root 'welcome#index'
  get '/feed', to: 'feed#index'
  get '/users/login', to: 'users#login', as: 'login'
  get '/users/logout', to: 'users#logout', as: 'logout'
  post '/users/login', to: 'users#actually_login', as: 'login_action'
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
