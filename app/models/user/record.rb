# frozen_string_literal: true

module User
  class Record < ApplicationRecord
    self.table_name = 'users'
    has_many :todos, class_name: '::Todo::Record'

    validates :name, presence: true
    validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP, uniqueness: true
    validates :token, presence: true, length: { is: 36 }, uniqueness: true
    validates :password_digest, presence: true, length: { is: 64 }

    after_commit :send_welcome_email

    private

    def send_welcome_email
      UserMailer.with(user: self).welcome.deliver_later
    end
  end
end
