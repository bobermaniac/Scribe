require_relative 'core'

module Scribe
  class SuperclassDefinition < NONTERMINAL_CLASS
    def identifier
      self.element_of_type Identifier
    end

    def to_s
      "based on #{self.identifier}"
    end
  end
end