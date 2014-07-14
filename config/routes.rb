Rails.application.routes.draw do
  devise_for :users

  resources :recipes, only: [:new, :create, :index, :show, :edit, :update]

  resources :production_schedules

  resources :days, only: [:show] do
    resources :starting_inventories, only: [:new, :create, :show, :edit, :update, :delete]
    resources :added_inventories, only: [:new, :create, :show, :edit, :update, :delete]
    resources :ending_inventories, only: [:new, :create, :show, :edit, :update, :delete]
  end

  resources :weeks, only: [:index, :show]

  root to: "days#show", id: Date.today.to_formatted_s

end
