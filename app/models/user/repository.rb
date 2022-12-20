module User
  module Repository
    extend self

    AsReadonly = ->(user) { user&.tap(&:readonly!) }

    def create_user(name:, email:, password:, token:)
      user = Record.create(
        name: name.value,
        email: email.value,
        token: token.value,
        password_digest: password.encrypted
      ).then(&AsReadonly)
    end

    private

    def find_user_by(conditions)
      Record.find_by(conditions).then(&AsReadonly)
    end
  end
end
