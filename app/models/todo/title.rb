module Todo
  class Title
    private attr_accessor :value
    public :value
    def initialize(value)
      self.value = String(value).strip
    end

    def validation_error
      return "can't be blank"
    end

    def valid? = value.present?

    def invalid?(...) = !valid?(...)
  end
end
