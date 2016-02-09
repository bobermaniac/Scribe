require_relative 'core'

module Scribe
  class ImportsDefinition < NONTERMINAL_CLASS
    def items
      self.elements_of_type ImportDefinition
    end

    def to_s
      "imports { #{self.items.join(', ')} \n}"
    end
  end
end