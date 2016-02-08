require_relative 'core'

module Scribe
  class ScribeDirectiveParameter < NONTERMINAL_CLASS
    def value
      self.element_of_type(Identifier).value
    end

    def to_s
      "#{value}"
    end
  end
end