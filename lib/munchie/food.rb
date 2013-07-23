module Munchie
  class Food
    attr_reader :tokens

    def initialize(tokens)
      @tokens = tokens
    end

    def to_s
      output = []
      output << "Quantity: #{quantity.value}" if !quantity.nil?
      output << "Weight: #{weight}" if !weight.nil?
      output << "Volume: #{volume}" if !volume.nil?
      output << "Text: #{text}" if !text.nil?
      "<#{output.join(", ")}>"
    end

    def quantity
      tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Quantity) }.first
    end

    def weight
      tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Weight) }.first
    end

    def text
      tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Text) }
    end

    def volume
      tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Volume) }.first
    end
  end
end