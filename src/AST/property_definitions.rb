require_relative 'core'

module Scribe
  class PropertyDefinitions < NONTERMINAL_CLASS
    def definitions
      elements_of_type PropertyDefinition
    end

    def to_s
      self.definitions.join("\n")
    end
  end
end