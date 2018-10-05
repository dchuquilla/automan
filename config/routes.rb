Rails.application.routes.draw do
  root "landing#index"
  devise_for :users
  resources :cost_details
  resources :maintenance_histories do
    collection do
      get 'types', format: 'json'
    end
    member do
      get 'review'
    end
    resources :user_car_settings, only: [:edit, :update]
  end
  resources :cars do 
    member do
      get 'select'
      get 'update_current_km'
      get 'image_detach'
    end
  end
  resources :owners, except: [:index]
  resources :settings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
