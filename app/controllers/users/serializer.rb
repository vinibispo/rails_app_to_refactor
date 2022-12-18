class Users::Serializer
  private attr_accessor :user
  def initialize(user)
    self.user = user
  end

  def as_json
    user.persisted? ? { id: user.id, name: user.name, token: user.token } : user.errors.as_json
  end
end
