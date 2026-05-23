Rails.application.routes.draw do
  resources :categories
  resources :equipment
  resources :maintenance_records

  get "up" => "rails/health#show", as: :rails_health_check
end
