module Munchie::Tokens
  #
  class Volume
    include Munchie

    def scan(tokens)
      tokens.each do |token|
        if tag = scan_for_cups(token)      then token.tag(tag) end
        if tag = scan_for_spoons(token)    then token.tag(tag) end
        if tag = scan_for_teaspoons(token) then token.tag(tag) end
        if tag = scan_for_metric(token)    then token.tag(tag) end
      end
    end

    def scan_for_metric(token)
      Tag.new([:volume, :millilitres], 1) if token.text =~ /\A(ml)\z/
      Tag.new([:volume, :litres], 1000) if token.text =~ /\A(l)\z/
    end

    def scan_for_cups(token)
      Tag.new([:volume, :cups], 250) if token.text =~ /(cups?)/
    end

    def scan_for_spoons(token)
      Tag.new([:volume, :tablespoon], 15) if token.text =~ /(tbsp?|tablespoons?)/
    end

    def scan_for_teaspoons(token)
      Tag.new([:volume, :teaspoon], 5) if token.text =~ /(tsp|teaspoon)/
    end
  end
end
