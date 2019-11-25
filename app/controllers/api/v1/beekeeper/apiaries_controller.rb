module Api
  module V1
    module Beekeeper
      class ApiariesController < Api::ApplicationController
        before_action :authenticate_user!

        def index
          # TODO: authorization for self apiaries
          @apiaries = Apiary.all # current_user.apiaries
        end
      end
    end
  end
end
