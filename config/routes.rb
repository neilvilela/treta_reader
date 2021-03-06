Rails.application.routes.draw do
  resources :threads, only: [:show, :index] do
    get :sample, on: :collection
  end

  root to: "threads#index"

  get "*path", to: "catch_all#index"
end
