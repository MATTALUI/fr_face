Rails.application.routes.draw do
  root 'welcome#index'
  get '/feed', to: 'feed#index'
  get '/users/login', to: 'users#login', as: 'login'
  get '/users/logout', to: 'users#logout', as: 'logout'
  get '/users/password', to: 'users#password'
  patch '/users/password', to: 'users#change_password'
  post '/users/login', to: 'users#actually_login', as: 'login_action'
  post '/posts/new', to: 'posts#create', as: 'posts'
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
