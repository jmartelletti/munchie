module Munchie
  class Value < Token
    attr_accessor :type
    attr_accessor :value

    def initialize(token, type, value = nil)
      @type = type
      @value = value
      super(token)
    end

  end
end
