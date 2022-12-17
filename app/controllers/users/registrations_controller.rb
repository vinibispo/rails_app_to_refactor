# frozen_string_literal: true

class Users::RegistrationsController < ApplicationController
  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

    user_attributes = { name: user_params[:name], email: user_params[:email], password: user_params[:password],
                        password_confirmation: user_params[:password_confirmation] }

    status, json = RegisterUserService.new.call(user_attributes:)

    case [status, json]
    in [:password_err, _] | [:confirmation_err, _] | [:error, _]
      render_json(422, user: json)
    in [:ok, _]
      render_json(201, user: json)
    end
  end
end
