module User
  class RegisterAndSendWelcomeEmail
    private attr_accessor :repository
    def initialize(repository: Repository)
      self.repository = repository
    end

    def call(user_attributes:)
      password = Password.new(user_attributes[:password])
      password_confirmation = Password.new(user_attributes[:password_confirmation])
      email = Email.new(user_attributes[:email])
      name = Name.new(user_attributes[:name])

      errors = Password::ValidateWithConfirmation.call(password, password_confirmation)

      errors[:email] = email.validation_error if email.invalid?

      errors[:name] = name.validation_error if name.invalid?

      return [:attributes_err, errors] if errors.present?

      token = Token.default_value

      user = repository.create_user(
        name:,
        email:,
        token:,
        password:
      )

      Mailer.with(user:).welcome.deliver_later
      [:ok, user]
    end
  end
end
