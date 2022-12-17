class UncompleteTodoService
  def call(conditions:)
    status, todo = FindTodoService.new.call(**conditions)
    case status
    in :ok
      todo.uncomplete!
      [status, todo]
    else
      [status, todo]
    end
  end
end
