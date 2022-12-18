module Todo
  class Uncomplete
    def call(conditions:)
      status, todo = Find.new.call(**conditions)
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
