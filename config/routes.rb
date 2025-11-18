require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
               sessions: 'api/v1/users/sessions',
               registrations: 'users/registrations'
             }
  # Sidekiq::Web authentication is handled by Rack middleware in config/initializers/sidekiq.rb
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      post :auth, to: 'auth#create'
      post 'auth/register', to: 'auth#register'
      post 'auth/refresh', to: 'auth#refresh'
      delete :logout, to: 'auth#destroy'
      resources :deals, only: %i[index show create update destroy] do
        member do
          post :vote, to: 'votes#create'
        end
      end
      resources :users, only: %i[show update]
      namespace :admin do
        resources :exports, only: %i[show]
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
