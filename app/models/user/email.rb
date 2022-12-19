module User
  class Email
    private attr_accessor :value

    FORMAT = ::URI::MailTo::EMAIL_REGEXP

    private_constant :FORMAT

    public :value
    def initialize(value)
      self.value = String(value).strip.downcase
    end

    def validation_error
      errors = []
      errors << "can't be blank" if value.blank?
      errors << 'is invalid' unless value.match?(FORMAT)
      errors
    end

    def valid? = value.present? && value.match?(FORMAT)

    def invalid?(...) = !valid?(...)
  end
end
