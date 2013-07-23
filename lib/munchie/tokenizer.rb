module Munchie
  # Normalises, tokenises, then extracts values from a text string
  class Tokenizer

    def self.tokenize(text)
      tokenizers = [
        Munchie::Tokens::Scalar,
        Munchie::Tokens::Unit,
        Munchie::Tokens::Multiplier,
        Munchie::Tokens::Separator,
        Munchie::Tokens::Text,
        Munchie::Tokens::Volume,
        Munchie::Tokens::Quantity]

      # create tokens for each word
      tokens = text.split(' ').map { |word| Token.new(word) }

      # for each type of tag, tag our tokens
      tokenizers.each do |tokenizer|
       tokenizer.new.scan(tokens)
      end

      # return tokens that are tagged
      tokens.select { |token| token.tagged? }
    end
  end
end
