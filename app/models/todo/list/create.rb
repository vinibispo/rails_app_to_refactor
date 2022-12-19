module Todo
  class List::Create
    def call(todo_attributes:)
      todo = Record.create(todo_attributes)

      status = todo.persisted? ? :ok : :error

      [status, todo]
    end
  end
end
