module User
  class RegisterAndSendWelcomeEmail
    def call(user_attributes:)
      password = Password.new(user_attributes[:password])
      password_confirmation = Password.new(user_attributes[:password_confirmation])

      errors = {}
      errors[:password] = ["can't be blank"] if password.invalid?
      errors[:password_confirmation] = ["can't be blank"] if password_confirmation.invalid?

      return [:password_err, errors] if errors.present?

      if password != password_confirmation
        return [:confirmation_err, { password_confirmation: ["doesn't match password"] }]
      end

      password_digest = Digest::SHA256.hexdigest(password.value)
      user = User::Record.new(
        name: user_attributes[:name],
        email: user_attributes[:email],
        token: SecureRandom.uuid,
        password_digest:
      )

      if user.save
        Mailer.with(user:).welcome.deliver_later
        return [:ok, user] if user.save
      end

      [:error, user]
    end
  end
end
