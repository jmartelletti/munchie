module Munchie
  class Handler
    attr_reader :pattern
    attr_reader :handler_method

    def initialize(pattern, handler_method)
      @pattern = pattern
      @handler_method = handler_method
    end

    def match(tokens, parser)
      tokens.each_index do |i|
        #p i
        #puts tokens
        if tags_match?(@pattern, tokens, i)
          invoke(tokens, i, parser)
          puts "Tokens: #{tokens} after #{handler_method}"
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
      pattern_class = pattern.map { |x| Munchie.const_get(x.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }) }

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

    def invoke(tokens, index, parser)
      parser.send(@handler_method, tokens, index) #, options)
    end
  end
end
