module Munchie
  module Parsers
    class ScalarText < Munchie::Parser
      def pattern
        [:scalar, :text]
      end

      def parse(tokens, index)
        quantity = tokens[index].get_tag(Munchie::Tokens::Scalar)
        unit     = tokens[index+1].get_tag(Munchie::Tokens::Text)

        new_val = quantity.token.word.to_i

        new_token = Munchie::Values::Quantity.new("#{quantity.token.word}", "quantity", new_val)

        tokens.delete_at(index)

        tokens.insert(index, new_token)
      end

    end
  end
end