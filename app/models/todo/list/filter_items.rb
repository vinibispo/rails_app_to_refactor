module Todo
  class List::FilterItems
    def call(user_id:, status:)
      id = ID.new(user_id)
      return [:error, id.validation_error] if id.invalid?

      todos = case status
              in 'overdue' then Item::Record.overdue
              in 'completed' then Item::Record.completed
              in 'uncompleted' then Item::Record.uncompleted
              else Item::Record.all
              end

      todos.where(user_id: id.value)
    end
  end
end
