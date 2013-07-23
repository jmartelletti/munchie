module Munchie::Parsers
  #
  class Text < Munchie::Parser
    def pattern
      [:text]
    end

    def parse(tokens, index)
      #puts "index: #{index}"
      #puts "tokens size: #{tokens.size}"
      text = []

      i = index
      while i < tokens.size

        scan = tokens[i].get_tag(:separator)
        t = tokens[i].get_tag(:text) if scan.nil?

        #puts "#{i} #{scan.inspect}"
        break if !scan.nil?
        text << t if !t.nil?
        i += 1
      end

      return if text.size == 0

      #puts "text: #{text.inspect}"
      #puts "text.size: #{text.size}"
      val = ""
      text.each do |t|
        val << " #{t.token.text}"
      end

      i = text.size + index - 1
      #puts "matched text: #{val}"
      #puts "deleting from #{i}"

      while i >= index
        #puts "deleting #{tokens[i].text}"
        tokens.delete_at(i)
        i -= 1
      end

      new_token = Munchie::Values::Text.new(val, "text", val)

      tokens.insert(index, new_token)
    end
  end
end