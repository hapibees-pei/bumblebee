module Api
  module V1
    module Beelover
      class FundingsController < Api::ApplicationController
        before_action :authenticate_bee!

        def index
          @fundings = policy_scope(Funding)
        end

        def create
          @funding = Funding.new(funding_params)
          @funding.status = :pending
          @funding.user_id = current_user.id
          authorize @funding

          if @funding.save
            render status: :created
          else
            unprocessable_entity
          end
        end

        private

        def funding_params
          params.require(:funding).permit(:hive_id, :price_cents)
        end
      end
    end
  end
end
