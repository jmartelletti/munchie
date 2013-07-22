module Munchie
  # Normalises, tokenises, then extracts values from a text string
  class Parser

    def match(tokens)
      tokens.each_index do |i|
        if tags_match?(pattern, tokens, i)
          parse(tokens, i)
          puts "Tokens:     #{tokens} after #{self.class}"
        end
      end
    end

    def includes_tokens?(array, type)
      array.each do |a|
        return true if a.class.ancestors.include? type
      end
      false
    end

    def tags_match?(pattern, tokens, token_index)
      #puts "tags_match?(#{pattern}, #{tokens}, #{token_index})"

      token_class = tokens.map { |x| x.tags }
      pattern_class = pattern.map { |x| Munchie::Tokens.const_get(x.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }) }

      pattern_size = pattern.size
      matches = 0
      pattern_class.each_index do |pi|
        # if we're on the last token and there's no more to the right
        return false if token_class[token_index + pi].nil?

        matches += 1 if includes_tokens?(token_class[token_index + pi], pattern_class[pi])
      end

      return true if pattern.size == matches

      false
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

