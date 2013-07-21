module Munchie
  class Quantity < Tag

    def self.scan(tokens)
      tokens.each do |token|
        if t = scan_for_somethin(token)   then token.tag(t) end
      end
    end

    def self.scan_for_somethin(token)
      if token.word =~ /(bunch)/
        Quantity.new(self, $1)
      end
    end

    def to_s
      'quantity'
    end
  end


  class UnitKilograms < Quantity
    def to_s
      super << '-kilogram'
    end

    def initialize(value)
      @grams = 1000 * value.to_i
    end
  end

end