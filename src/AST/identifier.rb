require_relative 'core'

module Scribe
  class Identifier < NONTERMINAL_CLASS
    def value
      self.text_value
    end

    def to_s
      self.value
    end
  end
end