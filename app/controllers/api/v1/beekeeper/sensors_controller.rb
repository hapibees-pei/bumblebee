module Api
  module V1
    module Beekeeper
      class SensorsController < Api::ApplicationController
        before_action :authenticate_bee!

        def index
          @apiary = Apiary.find(params[:apiary_id])

          if @apiary
            query = "/api/v1/sensors?gateway_id=#{@apiary.id}"

            response = HTTParty.get("#{Rails.application.credentials.iot_url}#{query}")
            if response.code == 200
              parsed_response = response.parsed_response["data"].collect { |r| r["hive_id"] }
              hives = Hive.where(apiary_id: @apiary.id)
              sensor_ids = hives.collect { |s| s.sensor_id }
              @diff = parsed_response - sensor_ids
            end
          else
            bad_request
          end
        end
      end
    end
  end
end
