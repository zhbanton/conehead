Rails.application.routes.draw do
  devise_for :users

  resources :recipes

  resources :production_schedules

  root 'recipes#index'
end
