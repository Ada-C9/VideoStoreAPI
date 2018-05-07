Rails.application.routes.draw do
  resources :customers, only: [:index]

  resources :movies, only: [:index, :show, :create]

  resources :rentals, only: [:check_in, :check_out]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
