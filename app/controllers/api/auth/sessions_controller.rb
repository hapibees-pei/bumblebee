# frozen_string_literal: true

class Api::Auth::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json
  protect_from_forgery unless: -> { request.format.json? }

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super { @token = current_token }
    #render "api/auth/sessions/create"
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  #def respond_with(resource, _opts = {})
  #  render json: resource
  #end

  #def respond_to_on_destroy
  #  head :no_content
  #end
end
