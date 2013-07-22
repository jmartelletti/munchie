module Munchie
  module Parsers
    class ScalarMultiplier < Munchie::Parser
      def pattern
        [:scalar, :multiplier]
      end


      def parse(tokens, index)
        value = tokens[index].get_tag(Munchie::Tokens::Scalar)
        #unit     = tokens[index+1].get_tag(Multiplier)

        #new_val = quantity.type.to_f * unit.volume.to_f
        #puts new_val
        #puts "multiplier: #{value.type.to_i}"
        new_token = Token.new(value.type.to_i)
        new_token.tag(Munchie::Tokens::Multiplier.new(new_token, value.type.to_i))

        tokens.delete_at(index+1)
        tokens.delete_at(index)

        tokens.insert(index, new_token)
      end

    end
  end
end