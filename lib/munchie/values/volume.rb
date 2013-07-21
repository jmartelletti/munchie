module Munchie
  class VolumeVal < Value

    def to_s
      "#{@word} (volume: #{value}mls, metric)"
    end
  end
end