module Munchie
  module Values
    class Weight < Value

      def to_s
        "#{@text} (weight: #{value} grams, metric)"
      end
    end
  end
end