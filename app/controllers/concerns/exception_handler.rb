module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
  end

  private

  def unprocessable_entity
    json_response("api/v1/errors/unprocessable_entity", :unprocessable_entity)
  end

  def not_found
    json_response("api/v1/errors/not_found", :not_found)
  end

  def json_response(path, status = :ok)
    render path, status: status
  end
end
