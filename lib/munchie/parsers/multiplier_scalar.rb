module Munchie
  module Parsers
    class MultiplierScalar < Munchie::Parser
      def pattern
        [:multiplier, :scalar]
      end

      def parse(tokens, index)
        multiplier = tokens[index].get_tag(Munchie::Tokens::Multiplier)
        scalar     = tokens[index+1].get_tag(Munchie::Tokens::Scalar)

        puts "multiplying #{scalar.value} x #{multiplier.value}"

        new_val = scalar.value.to_f * multiplier.value.to_f
        puts "new val: #{new_val}"

        scalar.value = new_val
        scalar.type = new_val
        scalar.token.word = new_val

        puts "scalar.value: #{scalar.value}"

        tokens.delete_at(index)
      end
    end
  end
end