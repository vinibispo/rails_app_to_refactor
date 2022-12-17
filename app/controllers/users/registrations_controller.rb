# frozen_string_literal: true

class Users::RegistrationsController < ApplicationController
  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

    user_attributes = { name: user_params[:name], email: user_params[:email], password: user_params[:password],
                        password_confirmation: user_params[:password_confirmation] }

    status, user = RegisterUserService.new.call(user_attributes:)

    case [status, user]
    in [:password_err, _] | [:confirmation_err, _] 
      render_json(422, user:)
    in [:error, User]
      render_json(422, user: UserSerializer.new(user).as_json)
    in [:ok, User]
      render_json(201, user: UserSerializer.new(user).as_json)
    end
  end
end
