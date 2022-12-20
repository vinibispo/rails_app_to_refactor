module Todo::Item
  class Update
    def call(conditions:, attributes:)
      status, todo = Find.new.call(**conditions)

      if attributes[:title].present?
        title = ::Todo::Title.new(attributes[:title])
        attributes[:title] = title.value
      end

      case status
      in :ok
        return [:ok, todo] if todo.update(attributes)

        [:error, todo]
      else
        [status, todo]
      end
    end
  end
end
