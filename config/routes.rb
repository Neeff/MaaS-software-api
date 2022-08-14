Rails.application.routes.draw do
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :available_hours, only: %i[index update], defaults: { format: :json }
  resources :services, defaults: { format: :json }
  resources :shifts, only: %i[index update], defaults: { format: :json }
end
