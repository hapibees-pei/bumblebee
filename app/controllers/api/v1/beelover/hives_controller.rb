module Api
  module V1
    module Beelover
      class HivesController < Api::ApplicationController
        before_action :authenticate_bee!

        def index
          @hives = policy_scope(Hive)
        end

        def show
          @hive = Hive.find(params[:id])
        end
      end
    end
  end
end
