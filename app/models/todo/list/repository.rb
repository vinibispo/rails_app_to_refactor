module Todo
  module List::Repository
    extend self

    AsReadonly = ->(item) { item.tap(&:readonly!) }

    def add_item(title:, due_at:, user_id:)
      created_at = ::Time.current
      data = { created_at:, updated_at: created_at, title: title.value, due_at:}
      Item::Record.create(data.merge(user_id: user_id.value)).then(&AsReadonly)
    end

    def filter_items(status:, user_id:)
      
      todos = case status
              in 'overdue' then Item::Record.overdue
              in 'completed' then Item::Record.completed
              in 'uncompleted' then Item::Record.uncompleted
              else Item::Record.all
              end
      todos.where(user_id: user_id.value)
    end
  end
end
