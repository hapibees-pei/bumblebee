module Api
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include ActionController::MimeResponds
    include Pundit
    
    respond_to :json

    before_action :require_json_request
    after_action -> { request.session_options[:skip] = true }

    def authenticate_bee!
      unless current_user
        unauthorized
      else
        true
      end
    end

    private

    def require_json_request
      if request.format.json?
        true
      else
        bad_request
      end
    end
  end
end
