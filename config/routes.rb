Rails.application.routes.draw do
  root "landing#index"
  devise_for :users
  resources :cost_details
  resources :cars do 
    member do
      get 'select'
      get 'dashboard'
      get 'reports'
      get 'gas_consume'
      get 'update_current_km'
      get 'image_detach'
      get 'image_detach'
    end
    collection do
      get 'brands', format: 'json'
      get 'models', format: 'json'
      get 'update_current_kms'
      get 'dismiss_car_update'
    end
    resources :maintenance_histories do
      member do
        get 'image_detach'
      end
      collection do
        get 'types', format: 'json'
        get 'last_maintenance_dates'
      end
      member do
        get 'review'
        get 'gas'
      end
      resources :user_car_settings, only: [:edit, :update]
    end
  end
  resources :owners, except: [:index]
  resources :settings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
