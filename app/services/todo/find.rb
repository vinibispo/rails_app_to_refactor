class Todo
  class Find
    def call(user_id:, id:)
      todo = Todo.find_by(user_id:, id:)
      status = todo.present? ? :ok : :not_found
      [status, todo]
    end
  end
end
