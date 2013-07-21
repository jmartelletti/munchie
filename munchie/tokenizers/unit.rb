module Munchie
  class Unit < Tag

    def self.scan(tokens)
      tokens.each do |token|
        if t = scan_for_unit(token)   then token.tag(t) end
        if t = scan_for_units(token)   then token.tag(t) end
        if t = scan_for_kilograms(token)   then token.tag(t) end
      end
    end

    def self.scan_for_unit(token)
      if token.word =~ /\A(g)\z/
        UnitGram.new($1, 1)
      end
    end

    def self.scan_for_units(token)
      if token.word =~ /(large)/
        Unit.new($1)
      end
    end

    def self.scan_for_kilograms(token)
      if token.word =~ /(kg)/
        UnitKilogram.new($1, 1000)
      end
    end    

    def to_s
      'unit'
    end
  end

  class UnitGram < Unit
    def to_s
      super << '-gram'
    end
  end

  class UnitKilogram < Unit
  end

end