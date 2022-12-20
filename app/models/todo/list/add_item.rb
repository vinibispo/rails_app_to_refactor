module Todo
  class List::AddItem
    def call(todo_attributes:)
      title = Title.new(todo_attributes[:title])
      user_id = ID.new(todo_attributes[:user_id])
      errors = {}
      errors[:title] = [title.validation_error] if title.invalid?

      return [:attributes_err, errors] if errors.present?

      todo = Item::Record.create({
                                   title: title.value,
                                   due_at: todo_attributes[:due_at],
                                   user_id: user_id.value
                                 })

      status = todo.persisted? ? :ok : :error

      [status, todo]
    end
  end
end
