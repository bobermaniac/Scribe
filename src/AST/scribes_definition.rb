require_relative 'core'

module Scribe
  class ScribesDefinition < NONTERMINAL_CLASS
    def items
      self.elements_of_type ScribeDefinition
    end

    def to_s
      "scribes { #{items.join('\n\t')} \n}"
    end
  end
end