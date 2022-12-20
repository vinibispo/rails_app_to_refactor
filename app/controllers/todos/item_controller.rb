# frozen_string_literal: true

module Todos
  class ItemController < BaseController
    BuildItem = ->(item) { Serializer.new(item).as_json }
    private_constant :BuildItem

    def index
      todos = ::Todo::List::FilterItems.new.call(user_id: current_user.id, status: params[:status]&.strip&.downcase)

      render_json(200, todos: todos.map(&BuildItem))
    end

    def create
      todo_attributes = {
        user_id: current_user.id,
        title: todo_params[:title],
        due_at: todo_params[:due_at]
      }
      status, todo = ::Todo::List::AddItem.new.call(todo_attributes:)

      case [status, todo]
      in [:ok, _] then render_json(201, todo: BuildItem[todo])
      in [:error, _] then render_json(422, todo: BuildItem[todo])
      in [:attributes_err, _] then render_json(422, todo:)
      end
    rescue ActionController::ParameterMissing => e
      render_json(400, error: e.message)
    end

    def show
      status, todo = ::Todo::Item::Find.new.call(user_id: current_user.id, id: params[:id])
      case [status, todo]
      in [:ok, _] then render_json(200, todo: BuildItem[todo])
      else render_json(404, todo: { id: 'not found' })
      end
    end

    def destroy
      status, todo = ::Todo::Item::Delete.new.call(user_id: current_user.id, id: params[:id])

      case [status, todo]
      in [:ok, _] then render_json(200, todo: BuildItem[todo])
      else render_json(404, todo: { id: 'not found' })
      end
    end

    def update
      conditions = {
        id: params[:id],
        user_id: current_user.id
      }

      attributes = {
        title: todo_params[:title]
      }
      status, todo = ::Todo::Item::Update.new.call(conditions:, attributes:)

      case [status, todo]
      in [:ok, _] then render_json(200, todo: BuildItem[todo])
      in [:not_found, _] then render_json(404, todo: { id: 'not found' })
      else render_json(422, todo: BuildItem[todo])
      end
    rescue ActionController::ParameterMissing => e
      render_json(400, error: e.message)
    end

    private

    def todo_params
      params.require(:todo).permit(:title, :due_at)
    end
  end
end
