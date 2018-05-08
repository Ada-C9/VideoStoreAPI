Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]

  post '/rentals/check-out', to: 'rentals#checkout', as: 'check-out'

  post '/rentals/check-in', to: 'rentals#checkin', as: 'check-in'



end
