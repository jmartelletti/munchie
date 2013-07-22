module Munchie
  module Tokens
    class Text < Tag

      def self.scan(tokens)
        tokens.each do |token|
          if t = scan_for_text(token) then token.tag(t) end
        end
      end

      def self.scan_for_text(token)
        if token.word =~ /\A(\D+)\z/
          Text.new(self, $1)
        end
      end

      def to_s
        'text'
      end
    end
  end
end
