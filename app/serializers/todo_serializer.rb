class TodoSerializer
  private attr_accessor :todo
  def initialize(todo)
    self.todo = todo
  end

  def as_json
    todo.errors.present? ? todo.errors.as_json : todo.as_json(except: [:user_id], methods: [:status])
  end
end
