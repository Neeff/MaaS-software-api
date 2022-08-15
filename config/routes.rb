Rails.application.routes.draw do
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'available_hours/:service_id', to: 'available_hours#index', defaults: { format: :json }
  get 'shifts/:service_id', to: 'shifts#index', defaults: { format: :json }
  resources :available_hours, only: %i[update], defaults: { format: :json }
  resources :services, defaults: { format: :json }
  resources :shifts, only: %i[update], defaults: { format: :json }
end
