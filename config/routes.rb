Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]
  resources :rentals, only: [:index, :show]

  post 'rentals/check-out', to: 'rentals#create', as: 'checkout'
  patch 'rentals/check-in', to: 'rentals#update', as: 'checkin'

end
