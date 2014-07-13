Rails.application.routes.draw do
  devise_for :users

  resources :recipes, only: [:new, :create, :index, :show, :edit, :update]

  resources :production_schedules

  resources :days do
    get 'view_day', on: :collection
    get 'view_week', on: :collection
  end

  root 'days#view_day', day: Date.today
end
