Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, skip: :all
  namespace :api do
    namespace :v1 do
      resources :vehicles
    end
  end
  devise_scope :user do
    # If you change these urls and helpers, you must change these files too:
    # - config/initializers/devise.rb#JWT Devise
    # - spec/support/authentication_helper.rb
    post '/users/login' => 'sessions#create', as: :user_session
    delete '/users/logout' => 'sessions#destroy', as: :destroy_user_session
    post '/users/signup' => 'registrations#create', as: :user_registration
  end

  get '/check_auth', to: 'application#check_auth'
  get '/panel(/*path)', to: 'application#panel', as: :panel
  get '/(*path)', to: 'application#website', as: :website

  mount Sidekiq::Web => '/sidekiq'
  root to: 'application#website'
end
