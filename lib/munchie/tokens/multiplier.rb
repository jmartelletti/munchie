module Munchie
  module Tokens
    class Multiplier < Tag

      def self.scan(tokens)
        tokens.each do |token|
          if t = scan_for_multiplier(token) then token.tag(t) end
        end
      end

      def self.scan_for_multiplier(token)
        if token.word =~ /\Ax\z/
          Multiplier.new(self, 'x')
        end
      end

      def to_s
        'multiplier'
      end
    end
  end
end