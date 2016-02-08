require_relative 'core'

module Scribe
  class ImportDefinitions < NONTERMINAL_CLASS
    def definitions
      self.elements_of_type ImportDefinition
    end

    def to_s
      "imports { #{self.definitions.join(', ')} \n}"
    end
  end
end