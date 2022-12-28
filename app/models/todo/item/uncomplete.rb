module Todo::Item
  class Uncomplete < ::Command
    private attr_accessor :repository
    def initialize(repository: Repository)
      repository.respond_to?(:uncomplete_item) or raise ArgumentError
      self.repository = repository
    end

    def call(conditions:)
      conditions = { user_id: ::ID.new(conditions[:user_id]), id: ::ID.new(conditions[:id]) }

      return [:not_found, nil] if conditions.any? { |(_key, value)| value.invalid? }

      todo = repository.uncomplete_item(conditions:)
      return [:ok, todo] if todo.present?

      [:not_found, nil]
    end
  end
end
