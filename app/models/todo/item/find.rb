module Todo::Item
  class Find
    def call(user_id:, id:)
      id = ID.new(id)
      user_id = ID.new(user_id)

      return [:not_found, nil] if id.invalid? || user_id.invalid?

      todo = Record.find_by(user_id: user_id.value, id: id.value)
      status = todo.present? ? :ok : :not_found
      [status, todo]
    end
  end
end
