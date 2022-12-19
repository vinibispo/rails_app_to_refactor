module User
  class Name
    private attr_accessor :value
    public :value
    def initialize(value)
      self.value = String(value).strip
    end

    def validation_error
      errors = []
      errors << "can't be blank" if value.blank?
      errors
    end

    def valid? = value.present?

    def invalid?(...) = !valid?(...)


  end
end
