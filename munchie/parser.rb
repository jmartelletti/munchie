module Munchie
  class Parser
    include Handlers

    def parse(text)
      puts ""
      puts "----------------------------------------------------------------------------"
      puts "Parsing: #{text}"
      text = pre_normalize(text)
      puts "Normalised: #{text}"
      tokens = tokenize(text)
      puts "Tokens: #{tokens.inspect}"
      value = tokens_to_values(tokens)
      puts "Output: #{tokens}"
      puts "Parsed < < < < < < < < < < < < < < < < < < < < <"
      output = get_output(value)
    end

    def pre_normalize(text)
      text = text.to_s.downcase
      text.gsub!(/\(/, ' ')
      text.gsub!(/\)/, ' ')
      text.gsub!(/,/, ' , ')
      text.gsub!(/([\d\.]+)([A-Za-z]+)/, '\1 \2') # Split strings such as 600g 1.5kg 123oz
      text
    end

    def tokenize(text)
      # create tokens for each word
      tokens = text.split(' ').map { |word| Token.new(word) }

      # for each type of tag, tag our tokens
      [Scalar, Unit, Multiplier, Separator, Text, Volume, Quantity].each do |tok|
        tok.scan(tokens)
      end

      # return tokens that are tagged
      tokens.select { |token| token.tagged? }
    end

    def tokens_to_values(tokens) #, options)
      definitions = [
        Handler.new([:scalar, :scalar_fraction], :handle_scalar_fraction),
        Handler.new([:scalar, :multiplier],      :handle_scalar_multiplier),
        Handler.new([:scalar, :quantity],        :handle_scalar_quantity),
        Handler.new([:scalar, :volume],          :handle_scalar_volume),
        Handler.new([:scalar, :unit],          :handle_scalar_unit),
        Handler.new([:text],          :handle_text),

        #Handler.new([:scalar, :weight],          :handle_scalar_weight),

        #Handler.new([:text], :handle_text),
        #Handler.new([:weight], :handle_weight)
      ]

      definitions.each do |handler|
        handler.match(tokens, self)
      end

      tokens
    end

    def get_output(tokens)
      
      volume = tokens.select { |t| t.class.ancestors.include?(VolumeVal) }.first # t.tags.select { |x| x.kind_of? Weight } }
      if !volume.nil?
        puts "Volume: #{volume.word.to_f} mls"
      end

      weight = tokens.select { |t| t.class.ancestors.include?(WeightVal) }.first # t.tags.select { |x| x.kind_of? Weight } }
      if !weight.nil?
        puts "Weight: #{weight.word.to_f} grams"
      end
      text = tokens.select { |t| t.class.ancestors.include?(TextVal) } #.select(&:to_s)
      puts "Text: #{text.inspect}"
    end

  end
end