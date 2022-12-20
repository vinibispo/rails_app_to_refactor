class ID
  private attr_accessor :value
  public :value

  FORMAT = /\A\d+\z/

  def initialize(value)
    self.value = value if value.is_a?(::Integer)
    self.value ||= value.to_i if value.is_a?(::String) && value.match?(FORMAT)
  end

  def validation_error
    return 'must be a positive integer' unless value&.positive?
  end

  def valid? = value&.positive?

  def invalid?(...) = !valid?(...)
end
