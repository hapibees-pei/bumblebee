module Api
  module V1
    class ProfileController < Api::ApplicationController
      before_action :authenticate_bee!

      def index
        @user = current_user
      end
    end
  end
end
