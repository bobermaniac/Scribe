require_relative 'core'

module Scribe
  class PropertiesDefinition < NONTERMINAL_CLASS
    def items
      elements_of_type PropertyDefinition
    end

    def to_s
      self.items.join("\n")
    end
  end
end