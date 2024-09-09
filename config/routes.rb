Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :users
      resources :stations do
        get "nearby", on: :collection
      end
      resources :fuel_types
      resources :prices do
        get "latest_by_station", on: :collection
      end
      resources :reviews do
        get "by_station", on: :collection
      end
    end
  end
end
