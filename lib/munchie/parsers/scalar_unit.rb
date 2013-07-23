module Munchie::Parsers
  #
  class ScalarUnit < Munchie::Parser
    def pattern
      [:scalar, :unit]
    end

    def parse(tokens, index)
      quantity = tokens[index].get_tag(:scalar)
      unit     = tokens[index+1].get_tag(:unit)

      #new_token = Token.new("#{quantity.type}#{unit.type}")
      #puts "<> #{unit.volume}"
      new_val = quantity.value
      #new_token.tag(Weight.new(new_token))
      new_token = Munchie::Values::Weight.new("#{quantity.value}", "weight", new_val)

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end
  end
end