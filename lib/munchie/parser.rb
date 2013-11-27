module Munchie
  # Normalises, tokenises, then extracts values from a text string
  class Parser

    def match(tokens)
      tokens.each_index do |i|
        if tags_match?(tokens, i)
          parse(tokens, i)
          #puts "Tokens:     #{tokens} after #{self.class}"
        end
      end
    end

    # def includes_tokens?(array, type)
    #   array.each do |a|
    #     return true if a.class.ancestors.include? type
    #   end
    #   false
    # end

    def tags_match?(tokens, index)
      #puts "#{self.class}::tags_match?(#{tokens}, #{index}) / #{pattern.inspect}"
      tags = tokens.map { |x| x.tags }
      matches = 0
      pattern.each_index do |pi|
        # if we're on the last token and there's no more to the right
        return false if tags[index + pi].nil?
        token_tags = tags[index + pi].map(&:type).flatten
        matches += 1 if token_tags.include? pattern[pi]
      end

      pattern.size == matches ? true : false
    end

    def self.parse(tokens)
      parsers = [
        Munchie::Parsers::MultiplierScalar,
        Munchie::Parsers::ScalarFraction,
        Munchie::Parsers::ScalarMultiplier,
        Munchie::Parsers::ScalarQuantity,
        Munchie::Parsers::ScalarVolume, 
        Munchie::Parsers::ScalarUnit,
        Munchie::Parsers::ScalarText,
        Munchie::Parsers::Text]

      parsers.each do |parser|
        parser.new.match(tokens)
      end

      Munchie::Food.new(tokens)
    end

  end
end
