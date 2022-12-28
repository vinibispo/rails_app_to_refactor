module Todo::Item
  class Delete
    private attr_accessor :repository
    def initialize(repository: Repository)
      repository.respond_to?(:remove_item) or fail ArgumentError
      self.repository = repository
    end
    def call(conditions:)
      conditions = { user_id: ::ID.new(conditions[:user_id]), id: ::ID.new(conditions[:id]) }

      return [:not_found, nil] if conditions.any? { |(key, value)| value.invalid? }

      todo = repository.remove_item(conditions:)
      return [:ok, todo] if todo.present?
      [:not_found, nil]
    end
    singleton_class.public_send(:alias_method, :[], :new)
  end
end
