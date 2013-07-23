module Munchie::Parsers
  #
  class ScalarText < Munchie::Parser
    def pattern
      [:scalar, :text]
    end

    def parse(tokens, index)
      quantity = tokens[index].get_tag(:scalar)

      new_token = Munchie::Values::Quantity.new(quantity.token.text, :quantity, quantity.value)

      tokens.delete_at(index)
      tokens.insert(index, new_token)
    end
  end
end