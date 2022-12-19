module Todos
  class Item::UncompleteController < BaseController
    def update
      conditions = {
        id: params[:id],
        user_id: current_user.id
      }

      status, todo = ::Todo::Item::Uncomplete.new.call(conditions:)
      case status
      in :ok then render_json(200, todo: Serializer.new(todo).as_json)
      else render_json(404, todo: { id: 'not found' })
      end
    end
  end
end
