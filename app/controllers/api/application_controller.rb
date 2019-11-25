module Api
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include ActionController::MimeResponds
    respond_to :json

    def authenticate_bee!
      unless current_user
        render "api/v1/errors/unauthorized", status: 401
      end
    end
  end
end
