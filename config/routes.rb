Rails.application.routes.draw do

  post 'rentals/check-out', to: 'rentals#check_out', as: 'check_out'

  post 'rentals/check-in', to: 'rentals#check_in', as: 'check_in'

  resources :customers, only: [:index]

  resources :movies, only: [:index, :show, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
