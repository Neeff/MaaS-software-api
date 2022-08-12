Rails.application.routes.draw do
  get 'shifts/index'
  get 'shifts/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :available_hours, only: %i[index update]
  resources :services
end
