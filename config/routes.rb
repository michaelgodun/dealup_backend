Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      post :auth, to: 'auth#create'
      resources :deals, only: %i[index show create update destroy] do
        member do
          post :vote, to: 'votes#create'
        end
      end
    end
  end
end
