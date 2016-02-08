require_relative 'core'

module Scribe
  class ScribeDefinitions < NONTERMINAL_CLASS
    def definitions
      self.elements_of_type ScribeDefinition
    end

    def to_s
      "#{definitions.join('\n')}"
    end
  end
end