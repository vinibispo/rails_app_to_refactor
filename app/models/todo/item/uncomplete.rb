module Todo::Item
  class Uncomplete
    def call(conditions:)
      status, todo = Find.new.call(**conditions)
      case status
      in :ok
        todo.update(completed_at: nil) unless todo.uncompleted?
        [status, todo]
      else
        [status, todo]
      end
    end
  end
end
