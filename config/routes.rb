Rails.application.routes.draw do
  get 'rentals/new'

  get 'rentals/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #customers_controller
    resources :customers, only:[:index]

  #movies_controller
    resources :movies, only:[:index, :show, :create]

  post 'rentals/check_out/:movie_id/:customer_id', to: 'rentals#create', as: 'rental'
end
