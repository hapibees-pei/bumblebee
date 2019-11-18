module Api
  class ApplicationController < ActionController::API
    include ExceptionHandler
    include ActionController::MimeResponds
    respond_to :json

    def verify_beekeeper
      render :unauthorized if current_user && !current_user.has_role?(:beekeeper)
    end

    def authenticate_bee!
      unless current_user
        render "api/v1/errors/401", status: 401
      end
    end
  end
end
