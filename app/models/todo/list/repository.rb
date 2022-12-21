module Todo
  module List::Repository
    extend self

    AsReadonly = ->(item) { item.tap(&:readonly!) }

    def add_item(title:, due_at:, user_id:)
      created_at = ::Time.current
      data = { created_at:, updated_at: created_at, title: title.value, due_at:}
      Item::Record.create(data.merge(user_id: user_id.value)).then(&AsReadonly)
    end
  end
end
