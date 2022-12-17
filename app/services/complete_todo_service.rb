class CompleteTodoService
  def call(conditions:)
    status, todo = FindTodoService.new.call(**conditions)
    case status
    in :ok
      todo.complete!
      [status, todo]
    else
      [status, todo]
    end
  end
end
