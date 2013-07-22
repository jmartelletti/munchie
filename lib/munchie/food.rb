module Munchie
  class Food
    def initialize(tokens)
      volume = tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Volume) }.first
      if !volume.nil?
        puts "Volume: #{volume.value.to_f} mls"
      end

      quantity = tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Quantity) }.first
      if !quantity.nil?
        puts "quantity: #{quantity.word.to_f}"
      end

      weight = tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Weight) }.first
      if !weight.nil?
        puts "Weight: #{weight.word.to_f} grams"
      end
      text = tokens.select { |t| t.class.ancestors.include?(Munchie::Values::Text) }
      puts "Text: #{text.inspect}"
    end

    def to_s
      "Food"
    end
  end
end