module Munchie
  module Handlers
    module_function

    def handle_qantity(tokens) #, day, time_tokens, options)
      puts "handling quantity"

      quantity = tokens[0].get_tag(Scalar)
      unit     = tokens[1].get_tag(Unit)

      puts "Quantity: #{quantity}, Unit: #{unit}"
    end

    def handle_text(tokens, index)
      #puts "HANDLING TEXT....................................................."
      #puts tokens.inspect
      #puts "index: #{index}"
      #puts "tokens size: #{tokens.size}"
      text = []

      i = index
      while i < tokens.size

        scan = tokens[i].get_tag(Separator)
        t = tokens[i].get_tag(Text) if scan.nil?
        

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
        val << " #{t.token.word}"
      end

      i = text.size + index - 1
      #puts "---"
      #puts "tokens: #{tokens.inspect}"
      #puts "token size: #{tokens.size}"
      #puts "index: #{index}"
      #puts "matched text: #{val}"
      #puts "deleting from #{i}"

      while i >= index
        #puts "deleting #{tokens[i].word}"
        tokens.delete_at(i)
        i -= 1
      end

      new_token = Munchie::TextVal.new(val, "text", val)

      tokens.insert(index, new_token)

      #puts 'done'
    end

    def handle_weight(tokens)
      weight = tokens[0].get_tag(Weight)
      "Weight: #{weight.type}"
    end

    def to_frac(fraction)
      numerator, denominator = fraction.split('/').map(&:to_f)
      denominator ||= 1
      numerator/denominator
    end

    def handle_scalar_unit(tokens, index)
      quantity = tokens[index].get_tag(Scalar)
      unit     = tokens[index+1].get_tag(Unit)

      #new_token = Token.new("#{quantity.type}#{unit.type}")
      #puts "<> #{unit.volume}"
      new_val = quantity.type
      #new_token.tag(Weight.new(new_token))
      new_token = Munchie::WeightVal.new("#{quantity.type}#{unit.type}", "weight", new_val)

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end

    def handle_scalar_multiplier(tokens, index)
      value = tokens[index].get_tag(Scalar)
      #unit     = tokens[index+1].get_tag(Multiplier)

      #new_val = quantity.type.to_f * unit.volume.to_f
      #puts new_val
      #puts "multiplier: #{value.type.to_i}"
      new_token = Token.new(value.type.to_i)
      new_token.tag(Multiplier.new(new_token, value.type.to_i))

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end

    require 'pry'
    def handle_scalar_volume(tokens, index)
      quantity = tokens[index].get_tag(Scalar)
      unit     = tokens[index+1].get_tag(Volume)

      new_val = quantity.token.word.to_f * unit.value.to_f
      #binding.pry
      #puts new_val
      new_token = Munchie::VolumeVal.new("#{quantity.token.word} #{unit.token.word}", "volime", new_val)

#      new_token = Token.new(new_val)
#      new_token.tag(Volume.new(new_val))

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end

    def handle_scalar_quantity(tokens, index)
      quantity = tokens[index].get_tag(Scalar)
      unit     = tokens[index+1].get_tag(Quantity)

      new_val = quantity.type.to_f #* unit.volume.to_f

      new_token = Token.new(new_val)
      new_token.tag(Quantity.new(new_token, new_val))

      tokens.delete_at(index+1)
      tokens.delete_at(index)

      tokens.insert(index, new_token)
    end

    def handle_scalar_fraction(tokens, index)
      scalar   = tokens[index].get_tag(Scalar)
      fraction = tokens[index+1].get_tag(ScalarFraction)

      new_val = scalar.type.to_f + to_frac(fraction.type)

      frac = Token.new(new_val)
      frac.tag(Scalar.new(frac, new_val))

      tokens.delete_at(index+1)
      tokens.delete_at(index)
      
      tokens.insert(index, frac)
    end
  end
end