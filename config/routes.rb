Rails.application.routes.draw do
  #Authentication
  resource :session, except: %i[ new ]
  get 'login', to: 'sessions#new', as: :new_session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'books#index'
  get "dashboard" => "pages#dashboard"

  resources :books do
    member do
      post 'borrow'
    end
  end
  
  resources :borrowings, only: [:index] do
    member do
      patch 'return'
    end
  end

  # Authentication routes
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :books, except: [:index, :show]
  end
end
