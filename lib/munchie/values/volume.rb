module Munchie
  module Values
    class Volume < Value

      def to_s
        "#{@word} (volume: #{value}mls, metric)"
      end
    end
  end
end