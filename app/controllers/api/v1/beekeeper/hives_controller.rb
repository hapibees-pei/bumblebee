module Api
  module V1
    module Beekeeper
      class HivesController < Api::ApplicationController
        before_action :authenticate_bee!
        before_action :verify_beekeeper

        def index
          # TODO: authorization
          @apiary = Apiary.find(params[:apiary_id])
          @hives = @apiary.hives
        end
      end
    end
  end
end
