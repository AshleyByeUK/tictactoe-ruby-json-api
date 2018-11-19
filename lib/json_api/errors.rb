module JsonAPI
  class DeserializationError < RuntimeError
    def initialize(msg)
      super(msg)
    end
  end
end
