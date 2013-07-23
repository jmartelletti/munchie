module Munchie::Tokens
  #
  class Scalar
    include Munchie

    def scan(tokens)
      tokens.each_index do |i|
        if tag = scan_for_fractions(tokens[i]) then tokens[i].tag(tag); next end
        if tag = scan_for_digits(tokens[i])    then tokens[i].tag(tag); next end
        if tag = scan_for_floats(tokens[i])    then tokens[i].tag(tag); next end
      end
    end

    def scan_for_digits(token)
      return Tag.new(:scalar, $1.to_i) if token.text =~ /\A(\d+)\z/
    end

    def scan_for_floats(token)
      return Tag.new([:scalar, :float], token.text.to_f) if token.text =~ /\A(\d+\.\d+)\z/
    end

    def scan_for_fractions(token)
      return Tag.new([:scalar, :fraction], to_frac(token.text)) if token.text =~ /\d+\s*\/\s*\d+/
      return Tag.new([:scalar, :fraction], to_frac('1/4')) if token.text =~ /¼/
      return Tag.new([:scalar, :fraction], to_frac('3/4')) if token.text =~ /¾/
      return Tag.new([:scalar, :fraction], to_frac('1/2')) if token.text =~ /½/
      return Tag.new([:scalar, :fraction], to_frac('1/3')) if token.text =~ /⅓/
    end

    private
    def to_frac(fraction)
      numerator, denominator = fraction.split('/').map(&:to_f)
      denominator ||= 1
      numerator/denominator
    end
  end
end