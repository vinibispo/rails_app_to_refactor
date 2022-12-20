module User
  class AuthenticateByToken
    private attr_accessor :repository
    def initialize(repository:)
      repository.respond_to?(:find_user_by_token) or raise ArgumentError
      self.repository = repository
    end

    def call(token:)
      user_token = Token.new(token)

      return nil if user_token.invalid?

      repository.find_user_by_token(user_token)

      Record.find_by(token: user_token.value)
    end
  end
end
