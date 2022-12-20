# frozen_string_literal: true

module Users
  class RegistrationsController < ApplicationController
    def create
      user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

      user_attributes = { name: user_params[:name], email: user_params[:email], password: user_params[:password],
                          password_confirmation: user_params[:password_confirmation] }

      status, user = ::User::RegisterAndSendWelcomeEmail.new(repository: ::User::Repository).call(user_attributes:)

      case [status, user]
      in [:attributes_err, _] then render_json(422, user:)
      in [:ok, _] then render_json(201, user: user_serializer(user))
      end
    rescue ActionController::ParameterMissing => e
      render_json(400, error: e.message)
    end

    private

    def user_serializer(user) = Serializer.new(user).as_json
  end
end
