module Api
  module V1
    class StatisticsController < Api::ApplicationController
      before_action :authenticate_bee!

      def show
      end
    end
  end
end
