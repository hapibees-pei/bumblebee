module Api
  module V1
    class StatisticsController < Api::ApplicationController
      before_action :authenticate_bee!

      def show
        statistics = StatisticsIntegration::Readings.new(params)
        @response = statistics.call

        render status: @response.code
      end
    end
  end
end
