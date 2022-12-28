module Todo::Item
  class Find
    private attr_accessor :repository
    def initialize(repository: Repository)
      repository.respond_to?(:find_item) or raise ArgumentError
      self.repository = repository
    end

    def call(user_id:, id:)
      id = ::ID.new(id)
      user_id = ::ID.new(user_id)

      return [:not_found, nil] if id.invalid? || user_id.invalid?

      todo = repository.find_item(user_id:, id:)
      status = todo.present? ? :ok : :not_found
      [status, todo]
    end
    singleton_class.public_send(:alias_method, :[], :new)
  end
end
