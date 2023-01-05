Rails.application.routes.draw do
  root "events#index"

  resources :events do
    resources :registrations
  end

  resource :session, only: %i[new create destroy]

  resources :users
  get "signup" => "users#new"
end
