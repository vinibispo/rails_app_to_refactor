module User
  class AuthenticateByToken
    def call(token:)
      user_token = Token.new(token)

      return nil if user_token.invalid?

      Record.find_by(token: user_token.value)
    end
  end
end
