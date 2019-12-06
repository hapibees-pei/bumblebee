module Api
  module V1
    class StatisticsController < Api::ApplicationController
      before_action :authenticate_bee!

      def show
        sensor_type = params[:sensor_type]
        hive_uuid = params[:hive_uuid]
        time_unity = params[:time_unity]

        url_options = "/api/v1/readings?query=#{sensor_type}&hive_id=#{hive_uuid}&group=#{time_unity}"
        @response = HTTParty.get(Rails.application.credentials.iot_url + url_options)
      end
    end
  end
end
