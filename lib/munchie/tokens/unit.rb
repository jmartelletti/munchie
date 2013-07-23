module Munchie::Tokens
  #
  class Unit
    include Munchie

    def scan(tokens)
      tokens.each do |token|
        if tag = scan_for_unit(token)      then token.tag(tag) end
        if tag = scan_for_units(token)     then token.tag(tag) end
        if tag = scan_for_kilograms(token) then token.tag(tag) end
      end
    end

    def scan_for_unit(token)
      Tag.new([:unit, :gram], 1) if token.text =~ /\A(g)\z/
    end

    def scan_for_units(token)
      Tag.new([:unit], $1) if token.text =~ /(large)/
    end

    def scan_for_kilograms(token)
      Tag.new([:unit, :kilogram], 1000) if token.text =~ /(kg)/
    end

  end
end
