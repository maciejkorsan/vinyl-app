Rails.application.routes.draw do
  root "dashboard#index"
  get "dashboard/index"
  get "history", to: "history#index"

  resource :session
  resources :passwords, param: :token
  resources :logs
  resources :artists

  resources :records do
    collection do
      get :search
      get :discogs_search
      get :discogs_results
      get :results
      post "import/:id", to: "records#discogs_import", as: :import
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
