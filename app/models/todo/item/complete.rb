module Todo::Item
  class Complete
    def call(conditions:)
      status, todo = Find.new.call(**conditions)
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
