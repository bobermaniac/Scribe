require_relative 'core'

module Scribe
  class ScribeDefinition < NONTERMINAL_CLASS
    def default?
      self.elements_of_type(ScribeDefaultsMarker).any?
    end

    def directives
      self.recursive_elements_of_type ScribeDirectiveGroup
    end

    def to_s
      return "\n\tdefault: { #{self.directives.join ''} \n\t}" if self.default?
      "\n\tapply: { #{self.directives.join ''} \n\t}"
    end
  end
end