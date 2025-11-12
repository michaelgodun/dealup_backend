require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

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
    end
  end
end
