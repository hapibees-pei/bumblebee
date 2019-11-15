module Api
  class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    respond_to :json

    def verify_beekeeper
      if current_user
        if !current_user.has_role?(:beekeeper)
          # TODO: HTTP 401
        end
      end
    end
  end
end
