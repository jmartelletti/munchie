module Munchie
  class Token
    attr_accessor :text
    attr_accessor :tags

    def initialize(text)
      @text = text
      @tags = []
    end

    def tag(new_tag)
      new_tag.token = self
      @tags << new_tag
    end

    def tagged?
      @tags.size > 0
    end

    def get_tag(tag_class)
      @tags.find { |m| m.type.include? tag_class }
    end

    def to_s
      "#{@text}(#{@tags.join(', ')})"
    end

    def inspect
      to_s
    end
  end
end