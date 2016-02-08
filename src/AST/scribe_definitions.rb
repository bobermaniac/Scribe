require_relative 'core'

module Scribe
  class ScribeDefinitions < NONTERMINAL_CLASS
    def definitions
      self.elements_of_type ScribeDefinition
    end

    def to_s
      "scribes { #{definitions.join('\n\t')} \n}"
    end
  end
end