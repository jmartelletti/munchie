module Munchie
  # Normalises a string prior to tokenization
  class Normalizer

    NORMALIZERS = [
      [/\(/, ' '],
      [/\)/, ' '],
      [/,/, ' , '],
      [/([\d\.]+)([^\/][\D\w])/, '\1 \2'] # Split strings such as 600g 1.5kg 123oz
    ]

    # Clean up the input text by running through normalization
    # steps, this prepares the string for tokenization 
    def self.normalize(text)
      text = text.to_s.downcase
      NORMALIZERS.each do |step|
        text.gsub!(step[0], step[1])
      end
      text
    end

  end
end