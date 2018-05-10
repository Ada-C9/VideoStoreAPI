Rails.application.routes.draw do

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]
  post 'rentals/check-out', to: 'rentals#checkout', as: 'checkout'
  post 'rentals/check-in', to: 'rentals#checkin', as: 'checkin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
