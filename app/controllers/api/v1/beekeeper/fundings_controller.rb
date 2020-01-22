module Api
  module V1
    module Beekeeper
      class FundingsController < Api::ApplicationController
        before_action :authenticate_user!

        def index
          @fundings = policy_scope(Funding)
        end

        def show
          @funding = Funding.find(params[:id])
          authorize @funding
        end
      end
    end
  end
end
