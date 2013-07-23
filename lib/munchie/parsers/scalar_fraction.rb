module Munchie::Parsers
  #
  class ScalarFraction < Munchie::Parser
    def pattern
      [:scalar, :scalar_fraction]
    end

    def parse(tokens, index)
      scalar   = tokens[index].get_tag(:scalar)
      fraction = tokens[index+1].get_tag(:scalar_fraction)

      new_val = scalar.type.to_f + fraction.value.to_f

      frac = Token.new(new_val)
      frac.tag(Munchie::Tokens::Scalar.new(frac, new_val))

      tokens.delete_at(index+1)
      tokens.delete_at(index)
      
      tokens.insert(index, frac)
    end
  end
end