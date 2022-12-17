class TodoFilterItemsService
  def call(user_id:, status:)
    todos = case status
            in 'overdue' then Todo.overdue
            in 'completed' then Todo.completed
            in 'uncompleted' then Todo.uncompleted
            else Todo.all
            end

    todos.where(user_id:)
  end
end
