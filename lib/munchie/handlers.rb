module Munchie
  module Handlers
    module_function

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

    def handle_multiplier_scalar(tokens, index)
      multiplier = tokens[index].get_tag(Multiplier)
      scalar     = tokens[index+1].get_tag(Scalar)

      puts "multiplying #{scalar.value} x #{multiplier.value}"

      new_val = scalar.value.to_f * multiplier.value.to_f
      puts "new val: #{new_val}"

      scalar.value = new_val
      scalar.type = new_val
      scalar.token.word = new_val

      puts "scalar.value: #{scalar.value}"

      tokens.delete_at(index)
    end

    def handle_scalar_volume(tokens, index)
      scalar = tokens[index].get_tag(Scalar)
      volume = tokens[index+1].get_tag(Volume)

      #puts "Scalar: #{scalar.value}"
      #puts "Volume: #{volume.value}"

      new_val = scalar.value.to_f * volume.value.to_f

      new_token = Munchie::VolumeVal.new("#{scalar.token.word} #{volume.token.word}", "volime", new_val)

      tokens.delete_at(index+1)
      tokens.delete_at(index)
      tokens.insert(index, new_token)
    end

    def handle_scalar_text(tokens, index)
      quantity = tokens[index].get_tag(Scalar)
      unit     = tokens[index+1].get_tag(Text)

      new_val = quantity.token.word.to_i

      new_token = Munchie::QuantityVal.new("#{quantity.token.word}", "quantity", new_val)

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

      new_val = scalar.type.to_f + fraction.value.to_f

      frac = Token.new(new_val)
      frac.tag(Scalar.new(frac, new_val))

      tokens.delete_at(index+1)
      tokens.delete_at(index)
      
      tokens.insert(index, frac)
    end
  end
end