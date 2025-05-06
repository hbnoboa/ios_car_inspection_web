Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  resources :measures
  resources :quadrants
  resources :nonconformity_locals
  resources :nonconformity_levels
  resources :nonconformity_types
  resources :vehicle_parts
  resources :vehicles do
    resources :nonconformities, module: :vehicles
    collection do
      get 'index_pdf', to: 'vehicles#index_pdf', as: 'vehicles_index_pdf'
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

  get 'vehicles/show_pdf/:id', to: 'vehicles#show_pdf', as: 'vehicles_show_pdf'
  get 'home', to: 'home#index'
  root 'home#index'
end
