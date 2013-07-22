module Munchie
  module Tokens
    class Scalar < Tag

      def self.scan(tokens)
        tokens.each_index do |i|
          if t = scan_for_fractions(tokens[i], tokens[i + 1]) then tokens[i].tag(t) end
          if t = scan_for_digits(tokens[i], tokens[i + 1])    then tokens[i].tag(t) end
          if t = scan_for_floats(tokens[i]) then tokens[i].tag(t) end
        end
      end

      def self.scan_for_digits(token, post_token)
        if token.word =~ /\A(\d+)\z/
          return Scalar.new($1.to_i, $1.to_i)
        end
      end

      def self.scan_for_floats(token)
        if token.word =~ /\A(\d+\.\d+)\z/
          return ScalarFloat.new(token.word.to_f, token.word.to_f)
        end
      end

      def self.scan_for_fractions(token, post_token)
        if token.word =~ /\d+\s*\/\s*\d+/
          return ScalarFraction.new(token.word, token.word)
        end

        if token.word =~ /¼/
          return ScalarFraction.new('1/4', '1/4')
        end

        if token.word =~ /¾/
          return ScalarFraction.new('3/4', '3/4')
        end

        if token.word =~ /½/
          return ScalarFraction.new('1/2', '1/2')
        end

        
        if token.word =~ /⅓/
          return ScalarFraction.new('1/3', '1/3')
        end
      end

      def to_s
        'scalar'
      end
    end

    class ScalarFloat < Scalar
      def to_s
        super << '-float'
      end
    end

    class ScalarFraction < Scalar
      def to_frac(fraction)
        numerator, denominator = fraction.split('/').map(&:to_f)
        denominator ||= 1
        numerator/denominator
      end

      def initialize(type, value)
        value = to_frac(value)
        super(type, value)
      end

      def to_s
        super << '-fraction'
      end
    end
  end
end