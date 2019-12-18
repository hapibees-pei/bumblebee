Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users,
    controllers: {
      sessions: "api/auth/sessions",
      passwords: "api/auth/passwords",
      registrations: "api/auth/registrations",
    },
    path: "auth", path_names: {
      sign_in: "login",
      sign_out: "logout",
    }
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :beekeeper do
        resources :apiaries, only: [:index, :create] do
          resources :hives, only: [:index, :create, :show, :update, :destroy]
        end
      end

      namespace :beelover do
        resources :hives, only: [:index, :show]
        resources :fundings, only: [:index, :create]
      end

      resources :profile, only: :index

      resources :apiaries do
        resources :statistics, only: :show
      end
    end
  end

  devise_for :admin_users
  
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :apiaries, only: [:index, :show]
    resources :hives, only: [:index, :show]

    root to: "users#index"
  end

  root to: "page#index", defaults: { format: :json }
end
