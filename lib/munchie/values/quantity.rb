module Munchie
  class QuantityVal < Value

    def to_s
      "Quantity: #{value} #{@word}"
    end
  end
end