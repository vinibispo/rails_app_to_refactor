module Todo
  class List::FilterItems < ::Command
    private attr_accessor :repository
    def initialize(repository: List::Repository)
      repository.respond_to?(:filter_items) or raise ArgumentError
      self.repository = repository
    end

    def call(user_id:, status:)
      user_id = ID.new(user_id)
      return [:error, user_id.validation_error] if user_id.invalid?

      todos = repository.filter_items(status:, user_id:)
    end

    singleton_class.public_send(:alias_method, :[], :new)
  end
end
