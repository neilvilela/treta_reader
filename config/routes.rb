Rails.application.routes.draw do
  resources :threads, only: [:show, :index]

  root to: "threads#index"

  get "*path", to: "catch_all#index"
end
