Rails.application.routes.draw do
  get 'requests/create_friendship'

  root 'welcome#index'
  get '/feed', to: 'feed#index'
  get '/users/login', to: 'users#login', as: 'login'
  get '/users/logout', to: 'users#logout', as: 'logout'
  get '/users/password', to: 'users#password'
  patch '/users/password', to: 'users#change_password'
  post '/users/login', to: 'users#actually_login', as: 'login_action'
  post '/users/:id/friend', to: 'friendships#create', as: 'new_friend'
  delete '/users/:id/friend/delete', to: 'friendships#delete', as: 'delete_friend'
  post '/users/:id/requests/friend', to: 'requests#create_friendship', as:'friend_request'
  post '/posts/new', to: 'posts#create', as: 'posts'
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
