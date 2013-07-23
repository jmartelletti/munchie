module Munchie
  module Values
    class Text < Value

      def to_s
        "text:#{@text}"
      end
    end
  end
end