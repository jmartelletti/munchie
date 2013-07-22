module Munchie
  module Values
    class Weight < Value

      def to_s
        "#{@word} (weight: #{value} grams, metric)"
      end
    end
  end
end