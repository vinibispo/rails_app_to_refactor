module Todo::Item
  class Update
    private attr_accessor :repository
    
    def initialize(repository: Repository)
      repository.respond_to?(:update_title) or fail ArgumentError
      self.repository = repository
    end

    def call(conditions:, attributes:)
      conditions = { user_id: ID.new(conditions[:user_id]), id: ID.new(conditions[:id])}

      return [:not_found, nil] if conditions.any? { |(_, value)| value.invalid? }

      title = ::Todo::Title.new(attributes[:title])

      errors = {}
      errors[:title] = [title.validation_error] if title.invalid?

      return [:attributes_err, errors] if errors.present?

      todo = repository.update_title(conditions:, title:)
      return [:not_found, todo] unless todo.present?

      [:ok, todo]
    end
    singleton_class.public_send(:alias_method, :[], :new)
  end
end
