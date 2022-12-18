class Todo
  class Update
    def call(conditions:, attributes:)
      status, todo = Find.new.call(**conditions)
      case status
      in :ok
        return [:ok, todo] if todo.update(attributes)

        [:error, todo]
      else
        [status, todo]
      end
    end
  end
end
