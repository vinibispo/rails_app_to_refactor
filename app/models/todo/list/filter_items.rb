module Todo
  class List::FilterItems
    def call(user_id:, status:)
      todos = case status
              in 'overdue' then Item::Record.overdue
              in 'completed' then Item::Record.completed
              in 'uncompleted' then Item::Record.uncompleted
              else Item::Record.all
              end

      todos.where(user_id:)
    end
  end
end
