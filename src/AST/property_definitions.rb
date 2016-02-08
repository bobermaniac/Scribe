require_relative 'core'

module Scribe
  class PropertyDefinitions < NONTERMINAL_CLASS
    def properties
      elements_of_type PropertyDefinition
    end
  end
end