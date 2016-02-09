require_relative 'core'

module Scribe
  class ScribeDefinition < NONTERMINAL_CLASS
    def default?
      self.elements_of_type(ScribeDefaultsMarker).any?
    end

    def groups
      self.recursive_elements_of_type ScribeDirectiveGroup
    end

    def to_s
      return "\n\tdefault: { #{self.groups.join ''} \n\t}" if self.default?
      "\n\tapply: { #{self.groups.join ''} \n\t}"
    end
  end
end