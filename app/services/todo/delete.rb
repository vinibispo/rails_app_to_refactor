class Todo
  class Delete
    def call(user_id:, id:)
      status, todo = Find.new.call(user_id:, id:)
      case status
      in :ok
        todo.destroy
        return [status, todo]
      else
        return [status, todo]
      end
    end
  end
end
