Munchie
=======

Munchie is a natural language food/diet log entry parser written in Ruby, inspired by the Chronic date/time parser.
See below for examples of the wide variety of formats Munchie will parse.

## Installation

```
$ gem install munchie
```

## Usage

```ruby
require 'munchie'

Munchie.parse('1 tbsp Olive Oil')
  #=> <Munchie::Food quantity=1 volume=<15ml>>

Munchie.parse('Derp')
  #=> nil
```

The parser will always return a Munchie::Food object with as many attributes as can be filled by extracting
values from the original input string.

See `Munchie.parse` for detailed usage instructions.

## Examples

Munchie can parse a huge variety of food log formats, from diet logs to recipes. Following is a
small sample of strings that will be properly parsed.

* ½ cup (70g) toasted hazelnuts, chopped
* 1 cup (90g) chopped dark chocolate
* 1¾ cups (255g) plain (all-purpose) flour, sifted
* 1 teaspoon baking powder, sifted
* 1 teaspoon bicarbonate of (baking) soda
* 1 teaspoon ground cinnamon
* ⅓ cup (115g) golden syrup
* 6 bananas, peeled and chopped
* 2 mangoes, peeled and chopped
* 1 cup (280g) vanilla-flavoured yoghurt
* 125g butter, softened
* 1 cup (175g) brown sugar
* 1 teaspoon vanilla extract
* 2 eggs
* 2 cups mashed banana
* 1 cup (160g) frozen raspberries
* ½ cup (25g) sweetened coconut flakes, plus extra, for sprinkling
* 1¾ cups (255g) plain (all-purpose) flour, sifted

## Contribute

If you'd like to hack on Chronic, start by forking the repo on GitHub:

https://github.com/jmartelletti/munchie

The best way to get your changes merged back is as follows:

1. Clone your fork of this repository
1. Create an appropriately named branch to work on your change
1. Hack away
1. Add tests and make sure everything still passes by running `rake`
1. If you are adding new functionality, document it in the Readme
1. Do not change the version number, we will do that at release time
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch