module Munchie
  # Normalises, tokenises, then extracts values from a text string
  class Parser
    include Handlers

    NORMALISATION_STEPS = [
      [/\(/, ' '],
      [/\)/, ' '],
      [/,/, ' , '],
      [/([\d\.]+)([^\/][\D\w])/, '\1 \2'] # Split strings such as 600g 1.5kg 123oz
    ]

    # Accepts a text string and attempts to recognise and extract known quantities
    # and measures, the values are then returned along with the remaining text.
    def parse(text)
      puts ""
      puts "----------------------------------------------------------------------------"
      puts "Parsing: #{text}"
      text = normalize(text)
      puts "Normalised: #{text}"
      tokens = tokenize(text)
      puts "Tokens: #{tokens.inspect}"
      value = tokens_to_values(tokens)
      puts "Output: #{tokens}"
      puts "Parsed < < < < < < < < < < < < < < < < < < < < <"
      output = get_output(value)
    end


    def normalize(text)
      text = text.to_s.downcase
      NORMALISATION_STEPS.each do |step|
        text.gsub!(step[0], step[1])
      end
      text
    end

    def tokenize(text)
      # create tokens for each word
      tokens = text.split(' ').map { |word| Token.new(word) }

      # for each type of tag, tag our tokens
      [Scalar, Unit, Multiplier, Separator, Text, Volume, Quantity].each do |token|
        token.scan(tokens)
      end

      # return tokens that are tagged
      tokens.select { |token| token.tagged? }
    end

    def tokens_to_values(tokens) #, options)
      definitions = [
        Handler.new([:scalar, :scalar_fraction], :handle_scalar_fraction),
        Handler.new([:scalar, :multiplier],      :handle_scalar_multiplier),
        Handler.new([:multiplier, :scalar],      :handle_multiplier_scalar),
        Handler.new([:scalar, :quantity],        :handle_scalar_quantity),
        Handler.new([:scalar, :volume],          :handle_scalar_volume),
        Handler.new([:scalar, :unit],            :handle_scalar_unit),
        Handler.new([:scalar, :text],            :handle_scalar_text),
        Handler.new([:text],                     :handle_text)
      ]

      definitions.each do |handler|
        handler.match(tokens, self)
      end

      tokens
    end

    def get_output(tokens)
      
      volume = tokens.select { |t| t.class.ancestors.include?(VolumeVal) }.first
      if !volume.nil?
        puts "Volume: #{volume.value.to_f} mls"
      end

      quantity = tokens.select { |t| t.class.ancestors.include?(QuantityVal) }.first
      if !quantity.nil?
        puts "quantity: #{quantity.word.to_f}"
      end

      weight = tokens.select { |t| t.class.ancestors.include?(WeightVal) }.first
      if !weight.nil?
        puts "Weight: #{weight.word.to_f} grams"
      end
      text = tokens.select { |t| t.class.ancestors.include?(TextVal) }
      puts "Text: #{text.inspect}"
    end

  end
end