Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :show, :create]

  resources :movies, only: [:index, :show, :create]

  get "/rentals/checkout", to: "rentals#checkout", as: "checkout"

  get "/rentals/checkin", to: "rentals#checkin", as: "checkin"
end
