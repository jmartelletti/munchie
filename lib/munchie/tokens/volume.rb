module Munchie
  class Volume < Tag
    attr_accessor :volume

    def self.scan(tokens)
      tokens.each do |token|
                if t = scan_for_cups(token)   then token.tag(t) end
        if t = scan_for_spoons(token) then token.tag(t) end
          if t = scan_for_teaspoons(token) then token.tag(t) end
        if t = scan_for_metric(token) then token.tag(t) end
      end
    end

    def self.scan_for_metric(token)
      if token.word =~ /\A(ml|l)\z/
        Volume.new($1, 1)
      end
    end

    def self.scan_for_cups(token)
      if token.word =~ /(cups?)/
        VolumeCup.new($1, 250)
      end
    end

    def self.scan_for_spoons(token)
      if token.word =~ /(tbsp?|tablespoons?)/
        VolumeTablespoon.new($1, 15)
      end
    end

    def self.scan_for_teaspoons(token)
      if token.word =~ /(tsp|teaspoon)/
        VolumeTeaspoon.new($1, 5)
      end
    end

    def to_s
      'volume'
    end
  end

    class VolumeTablespoon < Volume
    def to_s
      super << '-tablespoon'
    end
  end

  class VolumeTeaspoon < Volume
    def to_s
      super << '-teaspoon'
    end
  end

  class VolumeCup < Volume
    def to_s
      super << '-cup'
    end
  end

end