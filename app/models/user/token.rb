module User
  class Token
    private attr_accessor :value
    public :value

    LENGTH = 36

    private_constant :LENGTH

    def initialize(value)
      self.value = String(value).strip
    end

    def valid? = value.present? && value.length == LENGTH

    def invalid?(...) = !valid?(...)

    def self.default_value
      SecureRandom.uuid
    end
  end
end
