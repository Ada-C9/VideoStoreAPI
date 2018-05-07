Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customerss, only: [:index]

  # get '/customers/zomg', to: "customers#zomg", as: 'zomg'
end
