module Munchie
  class WeightVal < Value

    def to_s
      "#{@word} (weight: #{value} grams, metric)"
    end
  end
end