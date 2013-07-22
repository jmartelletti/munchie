module Munchie
  module Values
    class Text < Value

      def to_s
        "text:#{@word}"
      end
    end
  end
end