module Munchie
  module Parsers
    class ScalarQuantity < Munchie::Parser
      def pattern
        [:scalar, :quantity]
      end

      def parse(tokens, index)
        quantity = tokens[index].get_tag(Munchie::Tokens::Scalar)
        unit     = tokens[index+1].get_tag(Munchie::Tokens::Quantity)

        new_val = quantity.type.to_f #* unit.volume.to_f

        new_token = Token.new(new_val)
        new_token.tag(Munchie::Tokens::Quantity.new(new_token, new_val))

        tokens.delete_at(index+1)
        tokens.delete_at(index)

        tokens.insert(index, new_token)
      end
    end
  end
end