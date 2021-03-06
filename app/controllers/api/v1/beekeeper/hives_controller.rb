module Api
  module V1
    module Beekeeper
      class HivesController < Api::ApplicationController
        before_action :authenticate_bee!

        def index
          @apiary = Apiary.find(params[:apiary_id])
          @hives = policy_scope(@apiary.hives)
        end

        def create
          @apiary = Apiary.find(params[:apiary_id])
          @hive = Hive.new(hive_params)
          @hive.apiary_id = @apiary.id
          authorize @hive

          if @hive.save
            render status: :created
          else
            unprocessable_entity
          end
        end

        def show
          @hive = Hive.find(params[:id])
        end

        def update
          @hive = Hive.find(params[:id])
          authorize @hive

          @hive.update(hive_params)
        end

        def destroy
          @hive = Hive.find(params[:id])
          authorize @hive

          @hive.update(status: :perished)
        end

        private

        def hive_params
          params.require(:hive).permit(:name, :description, :bee_number, :sensor_id)
        end
      end
    end
  end
end
