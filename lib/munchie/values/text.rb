module Munchie
  class TextVal < Value

    def to_s
      "text:#{@word}"
    end
  end
end