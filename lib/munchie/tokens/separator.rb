module Munchie::Tokens
  #
  class Separator
    include Munchie

    def scan(tokens)
      tokens.each do |token|
        token.tag(Tag.new([:separator, :bracket], $1.to_i)) if token.text =~ /\A([\(|\)])\z/
        token.tag(Tag.new([:separator, :comma], ',')) if token.text =~ /\A,\z/
        # if t = scan_for_commas(token) then token.tag(t); next end
        # if t = scan_for_slash_or_dash(token) then token.tag(t); next end
        # if t = scan_for_at(token) then token.tag(t); next end
        # if t = scan_for_in(token) then token.tag(t); next end
        # if t = scan_for_on(token) then token.tag(t); next end
        # if t = scan_for_and(token) then token.tag(t); next end
      end
    end
  end
end
