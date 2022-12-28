class Command
  def initialize(**)
    raise ::NotImplementedError
  end

  def call(**)
    raise ::NotImplementedError
  end

  singleton_class.public_send(:alias_method, :[], :new)
end
