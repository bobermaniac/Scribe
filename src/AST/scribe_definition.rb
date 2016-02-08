require_relative 'core'

module Scribe
  class ScribeDefinition < NONTERMINAL_CLASS
    def default?
      self.elements_of_type(ScribeDefaultsMarker).any?
    end

    def directives
      groups = self.recursive_elements_of_type ScribeDirectiveGroup
      groups
    end

    def to_s
      "scribe definition default=#{self.default?} groups=#{self.directives.join ','}"
    end
  end
end