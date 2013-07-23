module Munchie
  module Values
    class Volume < Value

      def to_s
        "#{@text} (volume: #{value}mls, metric)"
      end
    end
  end
end