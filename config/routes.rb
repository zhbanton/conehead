Rails.application.routes.draw do
  devise_for :users

  resources :recipes :only [:new, :create, :index, :show, :edit, :update]

  resources :production_schedules

  root 'recipes#index'
end
