require 'munchie/handler'
require 'munchie/handlers'
require 'munchie/parser'
require 'munchie/tag'
require 'munchie/token'
require 'munchie/value'

require 'munchie/tokens/text'
require 'munchie/tokens/unit'
require 'munchie/tokens/multiplier'
require 'munchie/tokens/separator'
require 'munchie/tokens/scalar'
require 'munchie/tokens/weight'
require 'munchie/tokens/quantity'
require 'munchie/tokens/volume'

require 'munchie/values/volume'
require 'munchie/values/weight'
require 'munchie/values/text'
require 'munchie/values/quantity'

module Munchie
  VERSION = "0.1.0"

  def self.parse(text)
    Parser.new.parse(text)
  end
end
