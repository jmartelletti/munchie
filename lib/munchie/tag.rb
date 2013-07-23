module Munchie
  class Tag
    attr_accessor :token
    attr_accessor :type
    attr_accessor :value

    def initialize(type, value = nil)
      @type = *type
      @value = value
    end

    def to_s
      type.join(", ")
    end

    class << self
      private

      def scan_for(token, klass, items={})
        case items
        when Regexp
          return klass.new(self, token.text) if items =~ token.text
        when Hash
          items.each do |item, symbol|
            return klass.new(self, symbol) if item =~ token.text
          end
        end
        nil
      end

    end

  end
end