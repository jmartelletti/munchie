module Munchie::Parsers
  #
  class MultiplierScalar < Munchie::Parser
    def pattern
      [:multiplier, :scalar]
    end

    def parse(tokens, index)
      multiplier = tokens[index].get_tag(:multiplier)
      scalar     = tokens[index+1].get_tag(:scalar)

      puts "multiplying #{scalar.value} x #{multiplier.value}"

      new_val = scalar.value.to_f * multiplier.value.to_f
      puts "new val: #{new_val}"

      scalar.value = new_val
      #scalar.type = new_val
      scalar.token.text = new_val

      puts "scalar.value: #{scalar.value}"

      tokens.delete_at(index)
    end
  end
end