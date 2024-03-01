Rails.application.routes.draw do
  resources :measures
  resources :quadrants
  resources :nonconformity_locals
  resources :nonconformity_levels
  resources :nonconformity_types
  resources :vehicle_parts
  resources :vehicles do
    resources :nonconformities, module: :vehicles
    member do
      patch 'update_images', to: 'vehicles#update_images'
    end
  end

  devise_for :profiles, controllers: {
    registrations: 'profiles/registrations',
    sessions: 'profiles/sessions',
  }

  namespace :api do
    namespace :v1 do
      devise_for :profiles, controllers: { sessions: 'api/v1/sessions' }
    end
  end

  get 'home', to: 'home#index'
  root 'home#index'
end
