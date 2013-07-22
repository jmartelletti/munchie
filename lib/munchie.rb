require 'munchie/food'
require 'munchie/token'
require 'munchie/tag'
require 'munchie/value'
require 'munchie/parser'
require 'munchie/normalizer'
require 'munchie/tokenizer'

require 'munchie/tokens/text'
require 'munchie/tokens/unit'
require 'munchie/tokens/multiplier'
require 'munchie/tokens/separator'
require 'munchie/tokens/scalar'
require 'munchie/tokens/weight'
require 'munchie/tokens/quantity'
require 'munchie/tokens/volume'

require 'munchie/parsers/multiplier_scalar'
require 'munchie/parsers/scalar_fraction'
require 'munchie/parsers/scalar_multiplier'
require 'munchie/parsers/scalar_quantity'
require 'munchie/parsers/scalar_text'
require 'munchie/parsers/scalar_unit'
require 'munchie/parsers/scalar_volume'
require 'munchie/parsers/text'

require 'munchie/values/volume'
require 'munchie/values/weight'
require 'munchie/values/text'
require 'munchie/values/quantity'

module Munchie
  VERSION = "0.1.0"

  # Accepts a text string and attempts to recognise and extract known quantities
  # and measures, the values are then returned along with the remaining text.
  def self.parse(text)
    
    puts "Parsing:    \"#{text}\""
    text = Normalizer.normalize(text)
    puts "Normalised: \"#{text}\""
    tokens = Tokenizer.tokenize(text)
    puts "Tokens:     #{tokens.inspect}"
    food = Parser.parse(tokens)
    puts "Food:       #{food}"
    puts ""
  end
end
