module Munchie::Tokens
  #
  class Quantity
    include Munchie

    def scan(tokens)
      tokens.each do |token|
        if tag = scan_for_somethin(token) then token.tag(tag) end
      end
    end

    def scan_for_somethin(token)
      Tag.new(:quantity, 'bunch') if token.text =~ /(bunch)/
    end
  end
end
