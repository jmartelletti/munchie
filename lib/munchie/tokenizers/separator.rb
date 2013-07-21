module Munchie
  class Separator < Tag

    def self.scan(tokens)
      tokens.each do |token|
        if t = scan_for_commas(token) then token.tag(t); next end
        if t = scan_for_slash_or_dash(token) then token.tag(t); next end
        if t = scan_for_at(token) then token.tag(t); next end
        if t = scan_for_in(token) then token.tag(t); next end
        if t = scan_for_on(token) then token.tag(t); next end
        if t = scan_for_and(token) then token.tag(t); next end
      end
    end

    def self.scan_for_commas(token)
      scan_for token, SeparatorComma, { /^,$/ => :comma }
    end

    def self.scan_for_slash_or_dash(token)
      scan_for token, SeparatorSlashOrDash,
      {
        /^-$/ => :dash,
        /^\/$/ => :slash
      }
    end

    def self.scan_for_at(token)
      scan_for token, SeparatorAt, { /^(at|@)$/ => :at }
    end

    def self.scan_for_in(token)
      scan_for token, SeparatorIn, { /^in$/ => :in }
    end

    def self.scan_for_on(token)
      scan_for token, SeparatorOn, { /^on$/ => :on }
    end

    def self.scan_for_and(token)
      scan_for token, SeparatorAnd, { /^and$/ => :and }
    end

    def to_s
      'separator'
    end
  end

  class SeparatorComma < Separator
    def to_s
      super << '-comma'
    end
  end

  class SeparatorSlashOrDash < Separator
    def to_s
      super << '-slashordash-' << @type.to_s
    end
  end

  class SeparatorAt < Separator
    def to_s
      super << '-at'
    end
  end

  class SeparatorIn < Separator
    def to_s
      super << '-in'
    end
  end

  class SeparatorOn < Separator
    def to_s
      super << '-on'
    end
  end

  class SeparatorAnd < Separator
    def to_s
      super << '-and'
    end
  end
end