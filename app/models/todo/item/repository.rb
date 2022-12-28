module Todo::Item
  module Repository
    extend self

    AsReadonly = ->(item) { item&.tap(&:readonly!) }
    def find_item(user_id:, id:)
      conditions = { user_id: user_id.value, id: id.value }
      find_by(conditions:)&.then(&AsReadonly)
    end

    def update_title(conditions:, title:)
      conditions = { user_id: conditions[:user_id].value, id: conditions[:id].value }
      todo = find_by(conditions:)
      todo&.update(title: title.value)
      AsReadonly[todo]
    end

    def complete_item(conditions:)
      conditions = { user_id: conditions[:user_id].value, id: conditions[:id].value }
      todo = find_by(conditions:)
      todo&.update(completed_at: ::Time.current)
      AsReadonly[todo]
    end

    def uncomplete_item(conditions:)
      conditions = { user_id: conditions[:user_id].value, id: conditions[:id].value }
      todo = find_by(conditions:)
      todo&.update(completed_at: nil)
      AsReadonly[todo]
    end

    def remove_item(conditions:)
      conditions = { user_id: conditions[:user_id].value, id: conditions[:id].value }
      todo = find_by(conditions:)
      todo&.destroy
      AsReadonly[todo]
    end

    private

    def find_by(conditions:)
      Record.find_by(conditions)
    end
  end
end
