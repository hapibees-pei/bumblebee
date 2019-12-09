module Api
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include ActionController::MimeResponds
    include Pundit
    
    respond_to :json

    after_action -> { request.session_options[:skip] = true }

    def authenticate_bee!
      unless current_user
        unauthorized
      else
        true
      end
    end
  end
end
