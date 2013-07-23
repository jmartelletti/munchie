module Munchie::Parsers
  #
  class ScalarQuantity < Munchie::Parser
    include Munchie

    def pattern
      [:scalar, :quantity]
    end

    def parse(tokens, index)
      quantity = tokens[index].get_tag(:scalar)
      unit     = tokens[index+1].get_tag(:quantity)

      new_val = quantity.value.to_f #* unit.volume.to_f

      new_token = Token.new(new_val)
      new_token.tag(Tag.new(:quantity, new_val))

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end

  end
end