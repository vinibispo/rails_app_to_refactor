module User
  class AuthenticateByToken
    def call(token:) = Record.find_by(token:)
  end
end
