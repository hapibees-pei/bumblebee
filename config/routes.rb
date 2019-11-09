Rails.application.routes.draw do
  devise_for :users
  root to: "page#index", defaults: {format: :json}
end
