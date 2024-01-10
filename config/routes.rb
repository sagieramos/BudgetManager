Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  # ... other routes in your application

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#splash"

  # resources :entities, only: [:index, :new, :create, :show, :destroy, :edit, :update, :most_recent, :most_ancient]
  resources :groups, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :entities do
    collection do
      get 'most_recent'
      get 'most_ancient'
    end
  end
end
