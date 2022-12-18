# frozen_string_literal: true

module User
  class Mailer < ApplicationMailer
    def welcome
      user = params[:user]

      mail(
        to: user.email,
        body: "Hi #{user.name}, thanks for signing up...",
        subject: 'Welcome aboard',
        content_type: 'text/plain;charset=UTF-8'
      )
    end
  end
end
