module User
  class RegisterAndSendWelcomeEmail
    def call(user_attributes:)
      password = Password.new(user_attributes[:password])
      password_confirmation = Password.new(user_attributes[:password_confirmation])
      email = Email.new(user_attributes[:email])
      name = Name.new(user_attributes[:name])

      errors = Password::ValidateWithConfirmation.call(password, password_confirmation)

      errors[:email] = email.validation_error if email.invalid?

      errors[:name] = name.validation_error if name.invalid?

      return [:attributes_err, errors] if errors.present?

      password_digest = password.encrypted

      token = Token.default_value

      user = User::Record.create(
        name: name.value,
        email: email.value,
        token:,
        password_digest:
      )

      
      Mailer.with(user:).welcome.deliver_later
      return [:ok, user]
    end
  end
end
