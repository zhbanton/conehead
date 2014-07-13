Rails.application.routes.draw do
  devise_for :users

  resources :recipes, only: [:new, :create, :index, :show, :edit, :update]

  resources :production_schedules

  resources :days do
    get 'weeks', on: :collection
    resources :starting_inventories, only: [:new, :create, :show, :edit, :update, :delete]
  end

end
