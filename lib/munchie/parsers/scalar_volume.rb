module Munchie
  module Parsers
    class ScalarVolume < Munchie::Parser
      def pattern
        [:scalar, :volume]
      end

      def parse(tokens, index)
        scalar = tokens[index].get_tag(Munchie::Tokens::Scalar)
        volume = tokens[index+1].get_tag(Munchie::Tokens::Volume)

        new_val = scalar.value.to_f * volume.value.to_f

        new_token = Munchie::Values::Volume.new("#{scalar.token.word} #{volume.token.word}", "volime", new_val)

        tokens.delete_at(index+1)
        tokens.delete_at(index)
        tokens.insert(index, new_token)
      end
    end
  end
end