require_relative 'munchie/handler'
require_relative 'munchie/handlers'
require_relative 'munchie/parser'
require_relative 'munchie/tag'
require_relative 'munchie/token'
require_relative 'munchie/value'

require_relative 'munchie/tokenizers/text'
require_relative 'munchie/tokenizers/unit'
require_relative 'munchie/tokenizers/multiplier'
require_relative 'munchie/tokenizers/separator'
require_relative 'munchie/tokenizers/scalar'
require_relative 'munchie/tokenizers/weight'
require_relative 'munchie/tokenizers/quantity'
require_relative 'munchie/tokenizers/volume'

require_relative 'munchie/values/volume'
require_relative 'munchie/values/weight'
require_relative 'munchie/values/text'

module Munchie
  def self.parse(text, options = {})
    Parser.new.parse(text)
  end
end

require 'csv'
CSV.foreach("food.csv") do |row|
  Munchie.parse(row.join(" "))
end
