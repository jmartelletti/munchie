$:.unshift File.expand_path('../lib', __FILE__)
require 'munchie'

Gem::Specification.new do |s|
  s.name = 'munchie'
  s.version = Munchie::VERSION
  s.summary     = 'Natural language diet/food log entry parsing.'
  s.description = 'Munchie is a natural language diet/food log entry parsing (e.g. 1 tsp = ) library, inspired by the Chronic library for date/times.'
  s.authors  = ['James Martelletti']
  s.email    = ['james@martelletti.com.au']
  s.homepage = 'http://github.com/jmartelletti/munchie'
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = %w[Readme.md LICENSE]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test`.split("\n")

  s.add_development_dependency 'rake'
end
