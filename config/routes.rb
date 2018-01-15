Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'site/home'

  resources :posts
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
