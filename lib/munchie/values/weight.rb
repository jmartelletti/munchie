module Munchie
  class WeightVal < Value

    def to_s
      "#{@word} (value: #{value} grams, metric)"
    end
  end
end