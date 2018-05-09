Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #customers_controller
    resources :customers, only:[:index]

  #movies_controller
    resources :movies, only:[:index, :show, :create]

  post 'rentals/check-out', to: 'rentals#create', as: 'rental'

  post 'rentals/check-in/:rental_id', to: 'rentals#update', as: 'rental_update'

end
