module Api
  module V1
    module Beekeeper
      class ApiariesController < Api::ApplicationController
        before_action :authenticate_user!

        def index
          @apiaries = policy_scope(Apiary)
        end
      end
    end
  end
end
