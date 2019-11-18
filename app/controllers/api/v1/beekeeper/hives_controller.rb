module Api
  module V1
    module Beekeeper
      class HivesController < Api::ApplicationController
        before_action :authenticate_bee!
        before_action :verify_beekeeper

        def index
          @apiary = Apiary.find(params[:apiary_id])
          @hives = @apiary.hives
        end

        def create
          @apiary = Apiary.find(params[:apiary_id])
          @hive = Hive.create!(hive_params.merge(apiary_id: @apiary.id))
          render status: :created
        end

        def show
          @hive = Hive.find(params[:id])
        end

        def update
          @hive = Hive.find(params[:id])
          @hive.update(hive_params)
        end

        def destroy
          @hive = Hive.find(params[:id])
          @hive.update(status: :perished)
        end

        private

        def hive_params
          params.require(:hive).permit(:name, :description, :bee_number, :sensor_id, :status, :success_rate)
        end
      end
    end
  end
end
