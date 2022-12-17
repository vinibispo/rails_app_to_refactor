class Todo
  class UncompleteService
    def call(conditions:)
      status, todo = FindService.new.call(**conditions)
      case status
      in :ok
        todo.uncomplete!
        [status, todo]
      else
        [status, todo]
      end
    end
  end
end
