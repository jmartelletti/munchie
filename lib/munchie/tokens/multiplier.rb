module Munchie::Tokens
  #
  class Multiplier
    include Munchie

    def scan(tokens)
      tokens.each do |token|
        if tag = scan_for_multiplier(token) then token.tag(tag) end
      end
    end

    def scan_for_multiplier(token)
      return Tag.new(:multiplier, 'x') if token.text =~ /\Ax\z/
    end
  end
end