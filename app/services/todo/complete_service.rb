class Todo
  class CompleteService
    def call(conditions:)
      status, todo = FindService.new.call(**conditions)
      case status
      in :ok
        todo.complete!
        [status, todo]
      else
        [status, todo]
      end
    end
  end
end
