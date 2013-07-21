module Munchie
  class Token
    attr_accessor :word
    attr_accessor :tags

    def initialize(word)
      @word = word
      @tags = []
    end

    def tag(new_tag)
      new_tag.token = self
      @tags << new_tag
    end

    def untag(tag_class)
      @tags.delete_if { |m| m.kind_of? tag_class }
    end

    def tagged?
      @tags.size > 0
    end

    def get_tag(tag_class)
      @tags.find { |m| m.kind_of? tag_class }
    end

    def to_s
      "#{@word}(#{@tags.join(', ')})"
    end

    def inspect
      to_s
    end
  end
end