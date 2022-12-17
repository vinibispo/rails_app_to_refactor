# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :authenticate_user

  before_action :set_todo, only: %i[show destroy update complete uncomplete]

  rescue_from ActiveRecord::RecordNotFound do
    render_json(404, todo: { id: 'not found' })
  end

  def index
    json = TodoFilterItemsService.new.call(user_id: current_user.id, status: params[:status]&.strip&.downcase)

    render_json(200, todos: json)
  end

  def create
    todo_attributes = {
      user_id: current_user.id,
      title: todo_params[:title],
      due_at: todo_params[:due_at]
    }
    status, todo = CreateTodoService.new.call(todo_attributes:)

    case [status, todo]
    in [:ok, _] then render_json(201, todo: todo.serialize_as_json)
    in [:error, _] then render_json(422, todo: todo.errors.as_json)
    end
  end

  def show
    status, todo = FindTodoService.new.call(user_id: current_user.id, id: params[:id])
    case [status, todo]
    in [:ok, _] then render_json(200, todo: todo.serialize_as_json)
    else render_json(404, todo: { id: 'not found' })
    end
  end

  def destroy
    status, todo = DeleteTodoService.new.call(user_id: current_user.id, id: params[:id])

    case [status, todo]
    in [:ok, _] then render_json(200, todo: todo.serialize_as_json)
    else render_json(404, todo: { id: 'not found' })
    end
  end

  def update
    @todo.update(todo_params)

    if @todo.valid?
      render_json(200, todo: @todo.serialize_as_json)
    else
      render_json(422, todo: @todo.errors.as_json)
    end
  end

  def complete
    @todo.complete!

    render_json(200, todo: @todo.serialize_as_json)
  end

  def uncomplete
    @todo.uncomplete!

    render_json(200, todo: @todo.serialize_as_json)
  end

  private

    def todo_params
      params.require(:todo).permit(:title, :due_at)
    end

    def set_todo
      @todo = current_user.todos.find(params[:id])
    end
end
