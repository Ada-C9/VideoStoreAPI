Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :show, :create]
  resources :movies, only: [:index, :show, :create]
  # get '/customers/zomg', to: "customers#zomg", as: 'zomg'
end
