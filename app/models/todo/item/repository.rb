module Todo::Item
  module Repository
    extend self
    def find_item(user_id:, id:)
      conditions = { user_id: user_id.value, id: id.value }
      find_by(conditions:)
    end

    private

    def find_by(conditions:)
      Record.find_by(conditions)
    end
  end
end
