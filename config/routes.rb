Rails.application.routes.draw do
  get 'landing/index'
	root "landing#index"
  resources :cost_details
  resources :maintenance_histories
  resources :cars
  resources :owners
  resources :settings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
