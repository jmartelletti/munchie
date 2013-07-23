module Munchie::Parsers
  #
  class ScalarMultiplier < Munchie::Parser
    include Munchie

    def pattern
      [:scalar, :multiplier]
    end

    def parse(tokens, index)
      scalar = tokens[index].get_tag(:scalar)
      puts scalar.inspect
      #unit     = tokens[index+1].get_tag(Multiplier)

      #new_val = quantity.type.to_f * unit.volume.to_f
      #puts new_val
      #puts "multiplier: #{scalar.type.to_i}"
      new_token = Munchie::Token.new(scalar.value.to_i)
      new_token.tag(Tag.new(:multiplier, scalar.value.to_i))

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end


  end
end