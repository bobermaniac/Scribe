require_relative 'core'

module Scribe
  class ImportDefinition < NONTERMINAL_CLASS
    def value
      self.text_value
    end

    def to_s
      "\n\t#{self.element_of_type(Identifier).value}.h"
    end
  end
end