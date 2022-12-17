class Todo
  class CreateService
    def call(todo_attributes:)
      todo = Todo.create(todo_attributes)

      status = todo.persisted? ? :ok : :error

      [status, todo]
    end
  end
end
