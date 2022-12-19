module User
  class Password
    include Comparable
    private attr_accessor :value
    public :value

    def initialize(value)
      self.value = value.to_s.strip
    end

    def <=>(other)
      return value <=> other.value if other.is_a?(self.class)

      value <=> other
    end

    def validation_error
      return "can't be blank" if value.blank?
    end

    def encrypted = Digest::SHA256.hexdigest(value)

    def valid? = value.present?

    def invalid?(...) = !valid?(...)
  end
end
