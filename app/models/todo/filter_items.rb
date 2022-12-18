module Todo
  class FilterItems
    def call(user_id:, status:)
      todos = case status
              in 'overdue' then Record.overdue
              in 'completed' then Record.completed
              in 'uncompleted' then Record.uncompleted
              else Record.all
              end

      todos.where(user_id:)
    end
  end
end
