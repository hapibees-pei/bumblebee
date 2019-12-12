module Api
  module V1
    class StatisticsController < Api::ApplicationController
      before_action :authenticate_bee!

      def show
        sensor_type = params[:sensor_type]
        @hive = Hive.find(params[:hive_id])
        sensor_id = @hive.sensor_id
        apiary_id = params[:id]

        if params[:time_unity]
          time_unity = params[:time_unity]
          url_options = "/api/v1/readings?query=#{sensor_type}&apiary_id=#{apiary_id}&hive_id=#{sensor_id}&group=#{time_unity}"
        else
          url_options = "/api/v1/readings?query=#{sensor_type}&apiary_id=#{apiary_id}&hive_id=#{sensor_id}"
        end

        @response = HTTParty.get(Rails.application.credentials.iot_url + url_options)

        render status: @response.code
      end
    end
  end
end
