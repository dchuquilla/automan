Rails.application.routes.draw do
  resources :cost_details
  resources :maintenance_histories
  resources :cars
  resources :owners
  resources :settings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
