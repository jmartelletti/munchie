module Munchie
  class VolumeVal < Value

    def to_s
      "#{@word} (value: #{value}mls, metric)"
    end
  end
end