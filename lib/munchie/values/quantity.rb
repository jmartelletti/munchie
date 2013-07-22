module Munchie
  module Values
    class Quantity < Value

      def to_s
        "Quantity: #{value} #{@word}"
      end
    end
  end
end