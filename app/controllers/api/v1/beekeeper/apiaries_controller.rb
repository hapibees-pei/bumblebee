module Api
  module V1
    module Beekeeper
      class ApiariesController < Api::ApplicationController
        before_action :authenticate_user!

        def index
          @apiaries = policy_scope(Apiary)
        end

        def create
          @apiary = Apiary.new(apiary_params)
          @apiary.user_id = current_user.id
          authorize @apiary

          if @apiary.save
            IotApiaryJob.perform_later @apiary.id
            render status: :created
          else
            unprocessable_entity
          end
        end

        private

        def apiary_params
          params.require(:apiary).permit(:location, :ip, :port)
        end
      end
    end
  end
end
