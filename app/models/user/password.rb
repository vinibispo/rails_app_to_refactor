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

    def valid? = value.present?

    def invalid?(...) = !valid?(...)
  end
end
