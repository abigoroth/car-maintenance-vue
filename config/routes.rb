Rails.application.routes.draw do
  devise_for :administrators
  namespace :admin do
      mount Sidekiq::Web => '/sidekiq'
      resources :allowlisted_jwts
      resources :maintenance_schedules do
        get :send_whatsapp_reminder
      end
      resources :parts
      resources :service_reminders
      resources :users do
        get :login_as
        post :login_as
      end
      resources :vehicles
      resources :workshops
      resources :administrators

      root to: "allowlisted_jwts#index"
    end
  devise_for :users, defaults: { format: :json }, skip: :all
  namespace :api do
    namespace :v1 do
      resources :maintenance_schedules
      resources :vehicles do
        scope module: :vehicles do
          resources :maintenance_schedules do
            get :send_notification
          end
        end
      end
      resources :users
      resources :parts
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

  root to: 'application#website'
end
