module Munchie
  module Values
    class Quantity < Value

      def to_s
        "Quantity: #{value}"
      end
    end
  end
end