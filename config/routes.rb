Rails.application.routes.draw do


  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]

  post 'rentals/check-out', to: 'rentals#check_out', as: 'checkout'

  post 'rentals/check-in', to: 'rentals#check_in', as: 'checkin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
