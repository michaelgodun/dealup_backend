require "sidekiq/web"
Rails.application.routes.draw do
  # Sidekiq::Web authentication is handled by Rack middleware in config/initializers/sidekiq.rb
  mount Sidekiq::Web => "/sidekiq"

  # OAuth
  get '/auth/:provider', to: 'auth/omniauth_callbacks#passthru', as: :auth_provider
  get '/auth/:provider/callback', to: 'auth/omniauth_callbacks#google'
  get '/auth/failure', to: 'auth/omniauth_callbacks#failure'

  # Auth


  # V1
  namespace :api do
    namespace :auth do
      post 'login', to: 'auth#create'
      post 'register', to: 'auth#register'
      post 'refresh', to: 'auth#refresh'
    end
    namespace :v1 do
      resources :search_histories, only: %i[index create destroy]
      resources :deals, only: %i[index show create update destroy] do
        member do
          post :vote, to: 'votes#create'
        end
      end
      resources :users, only: %i[show update]
      namespace :admin do
        resources :exports, only: %i[show]
        resources :dashboards, only: %i[index]
        resources :users, only: [:index, :show, :destroy] do
          collection do
            post :csv
          end
        end
        resources :deals, only: [:index, :update, :destroy] do
          member do
            post :activate
          end
          collection do
            post :csv
          end
        end
        resources :comments, only: [:index, :update, :destroy] do
          collection do
            post :csv
          end
        end
      end
    end
  end
end
