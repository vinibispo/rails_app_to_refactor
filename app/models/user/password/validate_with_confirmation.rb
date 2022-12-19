module User
  module Password::ValidateWithConfirmation
    def self.call(password, password_confirmation)
      errors = {}
      errors[:password] = [password.validation_error] if password.invalid?
      errors[:password_confirmation] = [password.validation_error] if password_confirmation.invalid?
      errors[:password_confirmation] ||= ["doesn't match password"] if password != password_confirmation
      errors
    end
  end
end
