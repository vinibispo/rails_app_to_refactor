module Todo
  class List::AddItem < ::Command
    private attr_accessor :repository
    def initialize(repository: List::Repository)
      repository.respond_to?(:add_item) or raise ArgumentError
      self.repository = repository
    end

    def call(todo_attributes:)
      title = Title.new(todo_attributes[:title])
      user_id = ID.new(todo_attributes[:user_id])
      errors = {}
      errors[:title] = [title.validation_error] if title.invalid?

      return [:attributes_err, errors] if errors.present?

      todo = repository.add_item(
        title:,
        due_at: todo_attributes[:due_at],
        user_id:
      )

      status = todo.persisted? ? :ok : :error

      [status, todo]
    end
  end
end
