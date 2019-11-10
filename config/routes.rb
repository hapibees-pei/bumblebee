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

  root to: "page#index", defaults: { format: :json }
end
