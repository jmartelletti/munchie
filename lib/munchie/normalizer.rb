module Munchie

  # Normalises a string prior to tokenization
  class Normalizer

    # Clean up the input text by running through normalization
    # steps, preparing the string for tokenization 
    def self.normalize(text)
      normalizers = [
        [/\(/, ' ( '],
        [/\)/, ' ) '],
        [/,/, ' , '],
        [/([\d\.]+)([\w]|[^\/\d\s])/, '\1 \2'] # Split strings such as 600g 1.5kg 123oz
      ]

      text = text.to_s.downcase
      normalizers.each do |step|
        text.gsub!(step[0], step[1])
      end
      text
    end
  end
end