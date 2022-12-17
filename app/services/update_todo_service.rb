class UpdateTodoService
  def call(conditions:, attributes:)
    status, todo = FindTodoService.new.call(**conditions)
    case status
    in :ok
      return [:ok, todo] if todo.update(attributes)

      [:error, todo]
    else
      [status, todo]
    end
  end
end
