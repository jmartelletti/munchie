module Munchie::Tokens
  #
  class Text
    include Munchie

    def scan(tokens)
      tokens.each do |token|
        if t = scan_for_text(token) then token.tag(t) end
      end
    end

    def scan_for_text(token)
      return Tag.new(:text, $1) if token.text =~ /\A(\w+)\z/
    end
  end
end
